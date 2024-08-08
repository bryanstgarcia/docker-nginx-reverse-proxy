FROM nginx:latest as build
COPY /src/main /usr/share/nginx/main/
EXPOSE 80
RUN pwd