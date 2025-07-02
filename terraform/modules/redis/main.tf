resource "aws_security_group" "redis" {
  name        = "${var.name}-redis-sg"
  description = "Allow access to Redis only from Lambda redirect function"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow from Lambda Redirect"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    security_groups = [var.lambda_redirect_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-redis-sg"
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.name}-redis-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.name}-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]

  tags = {
    Name = "${var.name}-redis"
  }
}
