# Jenkins CI/CD Pipeline with Docker and Nginx

A simple Jenkins pipeline demonstrating CI/CD workflow for building and deploying a containerized Nginx application.

## Overview

This project showcases:
- Building a custom Nginx Docker image based on Red Hat UBI 8
- Running the container on a non-root user (port 8080)
- Pushing the image to a private Harbor registry

## Project Structure

```
├── Dockerfile        # Multi-stage Docker build for Nginx
├── Jenkinsfile       # CI/CD pipeline definition
├── index.html        # Sample HTML page served by Nginx
├── nginxconf.sed     # Nginx configuration modifications
└── README.md         # This file
```

## Prerequisites

- Jenkins with Docker plugin installed
- Docker daemon accessible from Jenkins agent
- Harbor registry credentials configured in Jenkins (credential ID: `harbor`)

## Pipeline Stages

1. **Verify Tooling** - Confirms Docker is available
2. **Checkout SCM** - Pulls the latest code
3. **Build Docker Image** - Creates the `nginx-hello` image
4. **Remove Orphan Containers** - Cleans up previous container instances
5. **Run Container** - Starts a new container on port 8080
6. **Push to Registry** - Tags and pushes to Harbor registry

## Local Development

```bash
# Build the image
docker build -t nginx-hello .

# Run the container
docker run -d --name nginx-hello -p 8080:8080 nginx-hello

# Test
curl http://localhost:8080
```

## Configuration

The `nginxconf.sed` file modifies the default Nginx configuration to:
- Listen on port 8080 instead of 80
- Run without root privileges
- Redirect logs to stderr for container compatibility