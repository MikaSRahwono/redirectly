package model

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/feature/dynamodb/attributevalue"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

var (
	tableName string = "shortened_links_dev" // Change this if needed
	dynamo    *dynamodb.Client
)

type ShortLink struct {
	ID          string `dynamodbav:"id"`
	OriginalURL string `dynamodbav:"original_url"`
	CreatedAt   string `dynamodbav:"created_at"`
	Clicks      int    `dynamodbav:"clicks"`
}

// Initializes the DynamoDB client
func initDynamo() error {
	if dynamo != nil {
		return nil
	}

	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		return fmt.Errorf("failed to load AWS config: %v", err)
	}

	dynamo = dynamodb.NewFromConfig(cfg)
	return nil
}

// Save shortlink to DynamoDB
func PutShortLink(link *ShortLink) error {
	if err := initDynamo(); err != nil {
		return err
	}

	av, err := attributevalue.MarshalMap(link)
	if err != nil {
		return fmt.Errorf("failed to marshal item: %v", err)
	}

	_, err = dynamo.PutItem(context.TODO(), &dynamodb.PutItemInput{
		TableName: aws.String(tableName),
		Item:      av,
	})
	return err
}

// Get shortlink from DynamoDB
func GetShortLink(id string) (*ShortLink, error) {
	if err := initDynamo(); err != nil {
		return nil, err
	}

	res, err := dynamo.GetItem(context.TODO(), &dynamodb.GetItemInput{
		TableName: aws.String(tableName),
		Key: map[string]types.AttributeValue{
			"id": &types.AttributeValueMemberS{Value: id},
		},
	})

	if err != nil {
		return nil, fmt.Errorf("failed to get item: %v", err)
	}
	if res.Item == nil {
		return nil, fmt.Errorf("link not found")
	}

	var link ShortLink
	if err := attributevalue.UnmarshalMap(res.Item, &link); err != nil {
		return nil, fmt.Errorf("failed to unmarshal item: %v", err)
	}

	return &link, nil
}

// Increment click counter
func IncrementClick(id string) error {
	if err := initDynamo(); err != nil {
		return err
	}

	_, err := dynamo.UpdateItem(context.TODO(), &dynamodb.UpdateItemInput{
		TableName: aws.String(tableName),
		Key: map[string]types.AttributeValue{
			"id": &types.AttributeValueMemberS{Value: id},
		},
		UpdateExpression: aws.String("SET clicks = clicks + :inc"),
		ExpressionAttributeValues: map[string]types.AttributeValue{
			":inc": &types.AttributeValueMemberN{Value: "1"},
		},
	})
	return err
}
