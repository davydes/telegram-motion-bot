#!/bin/sh
# $1 bot endpoint
# $2 bot token

curl\
  -F "url=${1}"\
  -F "certificate=@bot_cert_public.pem"\
  "https://api.telegram.org/bot${2}/setWebhook"
