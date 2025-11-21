# GetGatewayDatasourceIds.ps1
# Retrieves all datasource/connection IDs from a specified Power BI Gateway using Power BI REST API (delegated auth).

# -------------------------------
# Configuration (placeholders only)
# -------------------------------
$tenantId     = "<TENANT_ID>"
$clientId     = "<CLIENT_ID>"
$clientSecret = "<CLIENT_SECRET>"

# OAuth body for app-only auth (not used in this delegated example, included for completeness)
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = "https://analysis.windows.net/powerbi/api/.default"
}


# -------------------------------
# 0) Retrieve a delegated user token using Azure CLI
# -------------------------------
# Requires: `az login`
$userToken = (az account get-access-token `
    --resource https://analysis.windows.net/powerbi/api `
    --query accessToken -o tsv)


# -------------------------------
# 1) Retrieve all datasource (connection) IDs under a selected gateway
# -------------------------------

$gatewayId = "<GATEWAY_ID>"   # Replace locally; leave as placeholder in GitHub

$all = Invoke-RestMethod `
    -Headers @{ Authorization = "Bearer $userToken" } `
    -Uri "https://api.powerbi.com/v1.0/myorg/gateways/$gatewayId/datasources" `
    -Method GET

# Output datasource metadata
$all.value | Select-Object id, datasourceType, datasourceName, connectionDetails, credentialType, credentialDetails
