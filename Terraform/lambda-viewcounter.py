#Import json & boto3 library to interact with AWS DynamoDB
import json, boto3

#Define variables for boto3 client object and ddb table.
client = boto3.client('dynamodb')
TableName = 'ViewCounter'

def lambda_handler(event, context):
    
    #Update expression lets you increment/decrement a number on an item without needing to read the item (get) and to set the value. It does both in one.
    response = client.update_item(
        TableName='ViewCounter', #Required table name containing the item to update
        Key = {
            'Stat': {'S': 'view-count'} #Required primary key of the item to be updated.
        },
        UpdateExpression = 'ADD Quantity :inc', #Adds the specified value to 'Quantity' attribute
        ExpressionAttributeValues = {":inc" : {"N": "1"}},  #Increment type number by 1
        ReturnValues = 'UPDATED_NEW' #Represents the output of an UpdateItem expression, 'UPDATED_NEW' returns only the updated attributes.
    )
    
    #Extracts the updated value of the 'Quantity' attribute from the response of 'update_item()' method.
    value = response['Attributes']['Quantity']['N']
    
    #Return JSON Object with a status code 200 if successful and body with the updated value of 'Quantity' Attribute.
    return {      
        'statusCode': 200,
        'body': value
    }