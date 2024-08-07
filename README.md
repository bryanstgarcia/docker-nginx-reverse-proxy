# Docker NGINX Reverse Proxy
Creates a reverse proxy in a Docker container build with NGINX latest image 
- The reverse proxy expose the port 80 for http an 403 for https
- If a request is received with a http protocol it is redirect to https
## Requirements

- Docker
- A project build within a Docker container

## Documentation

Let's take a llok into all the files inside the project
### ./src folder
The `./src` folder contains a project example.

Inside the NGINX configuration is created a server to serve this 