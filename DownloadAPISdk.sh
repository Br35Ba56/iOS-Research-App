#/bin/bash
echo "Enter --rest-api-id"
read rest_api_id
echo "Enter --stage-name"
read stage_name

aws apigateway get-sdk --rest-api-id $rest_api_id --stage-name $stage_name --sdk-type swift --parameters classPrefix='MU' NFPApiSDK.zip
unzip NFPApiSDK.zip
cp -R ./aws-apigateway-ios-swift/generated-src/ ./Breast\ Feeding\ NFP/APIGatewaySDK/
rm -rf aws-apigateway-ios-swift
rm NFPApiSDK.zip
