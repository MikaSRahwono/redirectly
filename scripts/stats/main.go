package main

import (
	"encoding/json"
	"net/http"

	"github.com/MikaSRahwono/redirectly/model"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	id := req.PathParameters["shortId"]

	link, err := model.GetShortLink(id)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusNotFound, Body: "Not found"}, nil
	}

	jsonResp, _ := json.Marshal(link)
	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       string(jsonResp),
	}, nil
}

func main() {
	lambda.Start(handler)
}
