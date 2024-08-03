FROM nginx:latest as build
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY /src/dist /usr/share/nginx/dist/
COPY /src/api /usr/share/nginx/api/
COPY /src/main /usr/share/nginx/main/
EXPOSE 80
RUN pwd