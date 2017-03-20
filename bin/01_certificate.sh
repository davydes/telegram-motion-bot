#!/bin/sh
# $1 - hostname

openssl req\
  -newkey rsa:2048\
  -sha256\
  -nodes\
  -keyout bot_cert_private.key\
  -x509\
  -days 365\
  -out bot_cert_public.pem -subj\
  "/C=US/ST=New York/L=Brooklyn/O=Bot Brooklyn Company/CN=${1}"
