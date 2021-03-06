# Copyright 1998-2018 Epic Games, Inc. All Rights Reserved.

# $PublicIp = Invoke-WebRequest -Uri "http://169.254.169.254/latest/meta-data/public-ipv4" -UseBasicParsing

# $tmpData = Invoke-WebRequest -Uri "http://myip.dnsomatic.com/"
# $PublicIP = $tmpData.Content

$tmpData = Invoke-WebRequest -Uri "https://api.ipify.org"
$PublicIP = $tmpData.Content

Write-Output "Public IP: $PublicIp"

$peerConnectionOptions = "{ \""iceServers\"": [{\""urls\"": [\""stun:" + $PublicIp + ":19302\"",\""turn:" + $PublicIp + ":19303\""], \""username\"": \""PixelStreamingUser\"", \""credential\"": \""Another TURN in the road\""}] }"

$ProcessExe = "node.exe"
$Arguments = @("cirrus", "--peerConnectionOptions=""$peerConnectionOptions""", "--publicIp=$PublicIp")
# Add arguments passed to script to Arguments for executable
$Arguments += $args

Write-Output "Running: $ProcessExe $Arguments"
Start-Process -FilePath $ProcessExe -ArgumentList $Arguments -Wait -NoNewWindow
