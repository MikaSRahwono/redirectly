package main

import (
	"net/http"

	"github.com/MikaSRahwono/redirectly/model"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	id := req.PathParameters["shortId"]

	link, err := model.GetShortLink(id)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusNotFound, Body: "Link not found"}, nil
	}

	// Increment click count
	_ = model.IncrementClick(id)

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusFound,
		Headers: map[string]string{
			"Location": link.OriginalURL,
		},
	}, nil
}

func main() {
	lambda.Start(handler)
}
