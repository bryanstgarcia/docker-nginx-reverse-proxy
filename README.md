# 🐳 Docker NGINX Reverse Proxy 
Creates a reverse proxy in a Docker container build with NGINX latest image 
- The reverse proxy expose the port 80 for http an 403 for https
- If a request is received with a http protocol it is redirect to https

## ✅ Requirements

- Docker
- Docker compose
- Docker Network already created (actual name reverse-proxy-network )
- A project build within a Docker container in the network reverse-proxy-network

## 💾 Deployment
### 🚀 Release a new version into production Docker hub

This guide outlines the required steps to build and publish a new version of a Docker image to Docker Hub.

> ⚠️ Every release must include:
> - A version tag (e.g., `1.0.1`)
> - The `latest` tag pointing to that version

> Note 
> - The <version> should be replace
> - The <repo-name> should be replace with `reverse-proxy` or `cerbot-cloudflare`

---

### 🧱 Step 1: Build the image with a version tag

Replace `<version>` with the version you are releasing:

```shell
docker build ./nginx -t bryanstgarcia/reverse-proxy:<version> 

or

docker build -f ./Dockerfile.cerbot . -t bryanstgarcia/cerbot-cloudflare:<version>
```

### 🏷️ Step 2: Tag the image as latest

```shell
docker tag bryanstgarcia/<repo-name>:<version> bryanstgarcia/<repo-name>:latest
```
You can also use the image id to tag. Sometimes is easier.
This ensures that the latest tag always reflects the most recent version.

### 🔐 Step 3: Log in to Docker Hub (if not already logged in)
```shell
docker login
```
Enter your Docker Hub credentials when prompted.

### ☁️ Step 4: Push both tags to Docker Hub
```shell
docker push bryanstgarcia/<repo-name>:<version>
docker push bryanstgarcia/<repo-name>:latest
```
Both tags must be pushed for the release to be considered complete.

### ✅ Step 5: Verify the release on Docker Hub
Go to: https://hub.docker.com/repository/docker/bryanstgarcia/reverse-proxy

Make sure both tags are listed:

`<version>` and `latest`

### Create the Docker Network

All the apps that you want to connect to the reverse-proxy should be in the Docker network. First, lets create the network. 

Check if the network already exists. If exists, should show the network `reverse-proxy-network`

```shell
    docker network ls
```

If not, create the network:

```shell
    docker network create -d bridge reverse-proxy-network
```
There is a possibility that docker compose create it for you by default when running it.

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
4. Stop the container
    ```shell
    docker stop reverse-proxy # Stops container. If you use -d flag in step one, then just hit CTRL + C to stop it 
    ```
5. Delete the container
    ```shell
    docker rm reverse-proxy
    ```
6. Change `NGINX_CONFIG_FILE_NAME` ENV variable to `nginx.conf`
7. Build the container again. 
    ```shell
    docker-compose up -d --force-recreate --no-deps reverse-proxy # Monta únicamente el contenedor de del reverse-proxy sin correr el de certbot
    ```
