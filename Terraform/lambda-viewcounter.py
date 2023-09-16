import json, boto3

client = boto3.client('dynamodb')
TableName = 'ViewCounter'

def lambda_handler(event, context):
    
    response = client.update_item(
        TableName='ViewCounter',
        Key = {
            'Stat': {'S': 'view-count'}
        },
        UpdateExpression = 'ADD Quantity :inc',
        ExpressionAttributeValues = {":inc" : {"N": "1"}},
        ReturnValues = 'UPDATED_NEW'
        )
        
    value = response['Attributes']['Quantity']['N']
    
    return {      
        'statusCode': 200,
        'body': value
    }