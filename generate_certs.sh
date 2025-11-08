mkdir -p nginx/certs
openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/server.key -out nginx/certs/server.crt -days 365 -nodes -subj "/CN=localhost"
