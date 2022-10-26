#!/bin/bash
rnd=$RANDOM
groupName=tailwind-rg-2
accountName=tailwind-traders-$RANDOM
databaseName=tailwind
containerName=products

echo "Creating Resource Group"
az group create -l eastus -n $groupName

echo "Creating Cosmos DB database $accountName in Resource Group $groupName..."
echo "This can take up to 10 minutes. Feel free to continue with the Learn Module."
az cosmosdb create -n $accountName -g $groupName -o none


# Create a SQL API database
echo "Creating $databaseName"
az cosmosdb sql database create --account-name $accountName --resource-group $groupName --name $databaseName

# Add container named products data
echo "Creating container $containerName"
az cosmosdb sql container create -g $groupName -a $accountName -d $databaseName -n $containerName -p /brand/name -o none


endpoint=https://$accountName.documents.azure.com:443
echo "getting endpoint $endpoint"

key=$(az cosmosdb keys list -g $groupName -n $accountName --type keys --query "primaryMasterKey" -o json)
echo "getting endpoint $key"


## silent npm install
# npm install > "/dev/null" 2>&1

node ./POPULATE_DATABASE.js --endpoint $endpoint --key $key --databaseName $databaseName --containerName $containerName


# $connectionstrings[0].connectionString
echo "This is your connection string. Copy it to your clipboard..."
az cosmosdb keys list -n $accountName -g $groupName --type connection-strings --query "connectionStrings[0].connectionString" -o tsv


cmd /k