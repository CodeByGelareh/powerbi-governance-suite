// NOTE: Do not commit real access tokens to source control.
// Pass tokens into this function at runtime from a secure source.
// GetActivity.pq
// Recursively retrieves Power BI activity events using the admin/activityevents endpoint.
// Handles continuation tokens and stops after 100 loops for safety.

let
    GetActivity = (
        accessToken as text,
        optional startDate as text,
        optional endDate as text,
        optional continuationToken as text,
        optional loop as number,
        optional data as list
    ) as list =>
    let
        // Initialise defaults
        loopNum = if loop = null then 0 else loop,
        accumulatedData = if data = null then {} else data,

        // Build relative path depending on whether this is the first call or a continuation
        relativePath =
            if loopNum = 0 then
                "admin/activityevents?startDateTime=" & startDate & "&endDateTime=" & endDate
            else
                "admin/activityevents?continuationToken='" & continuationToken & "'",

        // Call Power BI REST API
        Source =
            Json.Document(
                Web.Contents(
                    "https://api.powerbi.com/v1.0/myorg/",
                    [
                        RelativePath = relativePath,
                        Headers = [ Authorization = "Bearer " & accessToken ]
                    ]
                )
            ),

        token = Source[continuationToken],
        currentData = Source[activityEventEntities],
        appendedData = List.Combine({accumulatedData, currentData}),

        output =
            if token = null or loopNum + 1 > 100 then
                appendedData
            else
                @GetActivity(accessToken, "", "", token, loopNum + 1, appendedData)
    in
        output
in
    GetActivity
