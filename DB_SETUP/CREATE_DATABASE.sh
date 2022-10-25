#!/bin/bash
echo "Creating Resource-Group"
az group create -l eastus -n tailwind_rg

rnd=$RANDOM
accountName=tailwind-traders-$RANDOM
databaseName=tailwind
containerName=products

echo "Beginning database creation process..."
groupName=tailwind_rg

echo "Creating Cosmos DB database $accountName in Resource Group $groupName..."
echo "This can take up to 10 minutes. Feel free to continue with the Learn Module."
az cosmosdb create -n $accountName -g $groupName -o none


# # ORIGNAL CODE
# #!/bin/bash
# rnd=$RANDOM
# accountName=tailwind-traders-$RANDOM
# databaseName=tailwind
# containerName=products

# echo "Beginning database creation process..."

# groupName=$(az group list --query "[4].name" -o tsv)

# echo "Creating Cosmos DB database $accountName in Resource Group $groupName..."
# echo "This can take up to 10 minutes. Feel free to continue with the Learn Module."
# az cosmosdb create -n $accountName -g $groupName -o none