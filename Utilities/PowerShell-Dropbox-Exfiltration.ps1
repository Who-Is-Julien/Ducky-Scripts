#Replace <APP_KEY> with the actual "App Key" of your app.
#Replace <APP_SECRET> with the actual "App Secret" of your app.
#Replace <REFRESH_TOKEN> with the actual "Refresh Token" of your app.


#Define the headers required for the access token request

$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}

#Define the parameters for the access token request

$body = @{
    grant_type    = "refresh_token"
    refresh_token = "<REFRESH_TOKEN>"
    client_id     = "<APP_KEY>"
    client_secret = "<APP_SECRET>"
}

#Request an access token from Dropbox using the body and headers defined above

$access_token_response = Invoke-RestMethod -Uri "https://api.dropboxapi.com/oauth2/token" -Method POST -Headers $headers -Body $body
$access_token = $access_token_response.access_token

#Define headers for the file upload

$headers = @{
"Authorization" = "Bearer $access_token"
"Content-Type" = "application/octet-stream"
"Dropbox-API-Arg" = '{ "path": "/reports/' + $env:computername + '.txt", "mode": "add", "autorename": true, "mute": false }'
}

#Define the report for the file upload

$body = "example"

#Upload the report to Dropbox using the headers and body defined above

Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" -Method POST -Headers $headers -Body $body | Out-Null
