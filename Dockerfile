FROM nginx:latest as build
RUN apt-get update && apt-get install -y \
    openssl \
    && rm -rf /var/lib/apt/lists/*
# Create the directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl
# Generate the self-signed certificate and private key
RUN openssl req -new -x509 -keyout /etc/nginx/ssl/self-signed.key -out /etc/nginx/ssl/self-signed.crt -days 365 -nodes \
    -subj "/C=US/ST=California/L=San Francisco/O=My Organization/OU=IT Department/CN=localhost/emailAddress=youremail@example.com"
COPY /src/main /usr/share/nginx/main/
EXPOSE 80
RUN pwd