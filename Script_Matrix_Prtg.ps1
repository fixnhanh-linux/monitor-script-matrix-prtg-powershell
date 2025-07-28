param (
    [string]$device     = $args[0],
    [string]$name       = $args[1],
    [string]$status     = $args[2],
    [string]$datetime   = $args[3],
    [string]$lastvalue  = $args[4],
    [string]$lastmessage= $args[5],
    [string]$probe      = $args[6],
    [string]$group      = $args[7],
    [string]$lastcheck  = $args[8],
    [string]$lastup     = $args[9],
    [string]$lastdown   = $args[10],
    [string]$uptime     = $args[11],
    [string]$downtime   = $args[12],
    [string]$cumsince   = $args[13],
    [string]$location   = $args[14],
    [string]$message    = ($args | Select-Object -Skip 15) -join " "
)

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    [Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

    $colorMap = @{
        "down"     = @{ Color="#d32f2f"; Emoji="&#10060;" }      # ❌
        "warning"  = @{ Color="#f57c00"; Emoji="&#9888;" }       # ⚠️
        "up"       = @{ Color="#388e3c"; Emoji="&#9989;" }       # ✅
        "unknown"  = @{ Color="#616161"; Emoji="&#10067;" }      # ❓
        "paused"   = @{ Color="#1976d2"; Emoji="&#9208;" }       # ⏸
        "unusual"  = @{ Color="#fbc02d"; Emoji="&#128310;" }     # 🔶
        "default"  = @{ Color="#0099FF"; Emoji="&#8505;" }       # ℹ️
    }

    $s = $status.ToLower()
    if ($colorMap.ContainsKey($s)) {
        $color = $colorMap[$s].Color
        $icon = $colorMap[$s].Emoji
    } else {
        $color = $colorMap["default"].Color
        $icon = $colorMap["default"].Emoji
    }

    # Tạo nội dung dạng text
    $plainLines = @()
    if ($status)     { $plainLines += "$icon [$status]" }
    if ($device)     { $plainLines += "Device: $device" }
    if ($name)       { $plainLines += "Sensor: $name" }
    if ($datetime)   { $plainLines += "Date/Time: $datetime" }
    if ($lastvalue)  { $plainLines += "Last Result: $lastvalue" }
    if ($lastmessage){ $plainLines += "Last Message: $lastmessage" }
    if ($probe)      { $plainLines += "Probe: $probe" }
    if ($group)      { $plainLines += "Group: $group" }
    if ($lastcheck)  { $plainLines += "Last Scan: $lastcheck" }
    if ($lastup)     { $plainLines += "Last Up: $lastup" }
    if ($lastdown)   { $plainLines += "Last Down: $lastdown" }
    if ($uptime)     { $plainLines += "Uptime: $uptime" }
    if ($downtime)   { $plainLines += "Downtime: $downtime" }
    if ($cumsince)   { $plainLines += "Cumulated Since: $cumsince" }
    if ($location)   { $plainLines += "Location: $location" }
    if ($message)    { $plainLines += "Message: $message" }

    $plainBody = $plainLines -join "`n"

    # Tạo nội dung dạng HTML
    $htmlLines = @()
    if ($status)     { $htmlLines += "<strong>$icon [$status]</strong><br />" }
    if ($device)     { $htmlLines += "<b>Device:</b> $device<br />" }
    if ($name)       { $htmlLines += "<b>Sensor:</b> $name<br />" }
    if ($datetime)   { $htmlLines += "<b>Date/Time:</b> $datetime<br />" }
    if ($lastvalue)  { $htmlLines += "<b>Last Result:</b> $lastvalue<br />" }
    if ($lastmessage){ $htmlLines += "<b>Last Message:</b> $lastmessage<br />" }
    if ($probe)      { $htmlLines += "<b>Probe:</b> $probe<br />" }
    if ($group)      { $htmlLines += "<b>Group:</b> $group<br />" }
    if ($lastcheck)  { $htmlLines += "<b>Last Scan:</b> $lastcheck<br />" }
    if ($lastup)     { $htmlLines += "<b>Last Up:</b> $lastup<br />" }
    if ($lastdown)   { $htmlLines += "<b>Last Down:</b> $lastdown<br />" }
    if ($uptime)     { $htmlLines += "<b>Uptime:</b> $uptime<br />" }
    if ($downtime)   { $htmlLines += "<b>Downtime:</b> $downtime<br />" }
    if ($cumsince)   { $htmlLines += "<b>Cumulated Since:</b> $cumsince<br />" }
    if ($location)   { $htmlLines += "<b>Location:</b> $location<br />" }
    if ($message)    { $htmlLines += "<b>Message:</b> $message<br />" }

    $htmlBody = "<span data-mx-color='$color'>" + ($htmlLines -join "`n") + "</span>"

    $body = @{
        msgtype = "m.notice"
        body = $plainBody
        format = "org.matrix.custom.html"
        formatted_body = $htmlBody
    } | ConvertTo-Json -Depth 10

    $url = "https://team.longvan.vn/_matrix/client/r0/rooms/!vQdUVTmHCrCpJjWxwR:team.longvan.vn/send/m.room.message"
    $token = "syt_MjAuMTM0OTU4LjE0MDM_WaktNVSQFUvllslHnaaj_1iHiE5"

    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type" = "application/json"
    }

    Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -ErrorAction Stop
}
catch {
    Write-Output "❌ Error: $_"
    exit 1
}
