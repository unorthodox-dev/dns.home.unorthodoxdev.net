#!/bin/sh
CERT_FILE="nginx/certs/server.crt"
DAYS_LEFT=$(openssl x509 -checkend $((30 * 24 * 3600)) -noout -in "$CERT_FILE" || echo "expired")

if [ "$DAYS_LEFT" = "expired" ]; then
  echo "Renewing self-signed certificate..."
  openssl req -x509 -newkey rsa:4096 \
    -keyout nginx/certs/server.key \
    -out nginx/certs/server.crt \
    -days 365 -nodes \
    -subj "/CN=localhost"
  docker compose restart nginx
else
  echo "Certificate still valid."
fi
