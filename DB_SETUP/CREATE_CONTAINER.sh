databaseName=tailwind
containerName=products
groupName=tailwind_rg

# Add products data
az cosmosdb sql container create -g $groupName -a $accountName -d $databaseName -n $containerName -p /brand/name -o none

endpoint=https://$accountName.documents.azure.com:443
key=$(az cosmosdb keys list -g $groupName -n $accountName --type keys --query "primaryMasterKey" -o json)

## silent npm install
npm install > "/dev/null" 2>&1

node ./POPULATE_DATABASE.js --endpoint $endpoint --key $key --databaseName $databaseName --containerName $containerName

echo "This is your connection string. Copy it to your clipboard..."
az cosmosdb keys list -n $accountName -g $groupName --type connection-strings --query "connectionStrings[0].connectionString" -o tsv