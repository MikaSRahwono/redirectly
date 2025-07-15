package create

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/MikaSRahwono/redirectly/model"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type CreateRequest struct {
	URL   string `json:"url"`
	Alias string `json:"alias"`
}

func generateShortID() string {
	return fmt.Sprintf("%d", time.Now().UnixNano()%1000000)
}

func handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var input CreateRequest
	if err := json.Unmarshal([]byte(req.Body), &input); err != nil || input.URL == "" {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusBadRequest, Body: "Invalid request"}, nil
	}

	id := input.Alias
	if id == "" {
		id = generateShortID()
	}

	// Check for existing alias
	_, err := model.GetShortLink(id)
	if err == nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusConflict, Body: "Alias already exists"}, nil
	}

	link := &model.ShortLink{
		ID:          id,
		OriginalURL: input.URL,
		CreatedAt:   time.Now().Format(time.RFC3339),
		Clicks:      0,
	}

	if err := model.PutShortLink(link); err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError, Body: "Failed to store link"}, nil
	}

	resp := map[string]string{
		"short_url": fmt.Sprintf("/%s", id),
	}
	jsonResp, _ := json.Marshal(resp)
	return events.APIGatewayProxyResponse{StatusCode: http.StatusOK, Body: string(jsonResp)}, nil
}

func main() {
	lambda.Start(handler)
}
