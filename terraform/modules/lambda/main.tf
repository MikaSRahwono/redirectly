resource "aws_iam_role" "lambda_exec" {
  name = "${var.environment}-${var.project_name}-lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Optional: attach DynamoDB & Redis access policies here
# You can customize each Lambda’s role separately if needed

# Function definitions
resource "aws_lambda_function" "create_url" {
  function_name = "${var.environment}-${var.project_name}-create_url"
  filename      = var.create_zip_path
  handler       = "index.handler"
  runtime       = "nodejs18.x" # or python3.11
  role          = aws_iam_role.lambda_exec.arn
  memory_size   = 128
  timeout       = 10
  environment {
    variables = var.env_variables
  }
}

resource "aws_lambda_function" "redirect_url" {
  function_name = "${var.environment}-${var.project_name}-redirect_url"
  filename      = var.redirect_zip_path
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec.arn
  memory_size   = 128
  timeout       = 3
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda_redirect_sg.id]
  }
  environment {
    variables = var.env_variables
  }
}

resource "aws_lambda_function" "get_stats" {
  function_name = "${var.environment}-${var.project_name}-get_stats"
  filename      = var.stats_zip_path
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec.arn
  memory_size   = 128
  timeout       = 10
  environment {
    variables = var.env_variables
  }
}


# Security Group for Lambda Redirect
# This allows the Lambda function to access Redis in the same VPC
resource "aws_security_group" "lambda_redirect_sg" {
  name        = "${var.project_name}-${var.project_name}-redirect-lambda-sg"
  description = "Allow Lambda Redirect to access Redis"
  vpc_id      = var.vpc_id

  # Egress to allow outgoing connections (e.g., to Redis in same VPC)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.project_name}-lambda-redirect-sg"
  }
}
