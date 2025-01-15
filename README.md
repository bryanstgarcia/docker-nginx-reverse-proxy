# 🐳 Docker NGINX Reverse Proxy 
Creates a reverse proxy in a Docker container build with NGINX latest image 
- The reverse proxy expose the port 80 for http an 403 for https
- If a request is received with a http protocol it is redirect to https

## ✅ Requirements

- Docker
- Docker compose
- Docker Network already created (actual name reverse-proxy-network )
- A project build within a Docker container in the network reverse-proxy-network

## 💾 Documentation

### 📑 Create SSL certificates

To be hable to create SSL certificates properly, it is neccesarly to run the container with the ENV variable set as shown `NGINX_CONFIG_FILE_NAME=pre-ssl-nginx.conf` this is gonna take the pre-ssl-file and help us to build and check the SSL certificates created by certbot container. After this configuration is applied, then it is required to re run the container but now with the ENV variable set to `NGINX_CONFIG_FILE_NAME=nginx.conf` wich includes all the configuration for the reverse proxy to work properly with the SSL configuration. This is gonna run a SSL certificate check.

### 🏃‍♂️ Let's run the project in production
1. Set the ENV variables to the corresponding values. Check `.env.example`
2. Update all the corresponding values for your domain in `nginx/nginx.conf` and `pre-ssl-nginx.conf`
3. Run the container to create the SSL certificates with certbot. Set the `NGINX_CONFIG_FILE_NAME` ENV variable to `pre-ssl-nginx.conf`

    ```shell
    docker compose up # See all the process running  (recommended)
    docker compose up -d # Detach mode
    ```
4. Stop de container
    ```shell
    docker stop reverse-proxy # Stops container. If you use -d flag in step one, then just hit CTRL + C to stop it 
    ```
5. Change `NGINX_CONFIG_FILE_NAME` ENV variable to `nginx.conf`
6. Build the container again. 
    ```shell
    docker build reverse-proxy
    ```
