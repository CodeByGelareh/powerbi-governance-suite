// GetAccessToken.pq. Call this fxAccessToken()
let
    GetAccessToken = () as text =>
        let
            tenant_id     = "<TENANT_ID>",
            client_id     = "<CLIENT_ID>",
            client_secret = "<CLIENT_SECRET>",
            resource = "https://analysis.windows.net/powerbi/api",

            url = "https://login.microsoftonline.com/" & tenant_id & "/oauth2/token",

            body = [
                grant_type    = "client_credentials",
                client_id     = client_id,
                client_secret = client_secret,
                resource      = resource
            ],

            response =
                Json.Document(
                    Web.Contents(
                        url,
                        [
                            Headers = [
                                Accept = "application/json",
                                #"Content-Type" = "application/x-www-form-urlencoded"
                            ],
                            Content = Text.ToBinary(Uri.BuildQueryString(body))
                        ]
                    )
                ),

            access_token = response[access_token]
        in
            access_token
in
    GetAccessToken
