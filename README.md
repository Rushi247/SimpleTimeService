
# SimpleTimeService

A simple microservice created in Java programming language using Maven and Spring boot. Dockerizing the application and to host the container in AWS cloud using Terraform. 

This microservice application is a web server that returns a pure JSON response with the following structure, when its / URL path is accessed:

{\
  "timestamp": "<current date and time>",\
  "ip": "<the IP address of the visitor>"\
}

## API Reference

Returns the current server timestamp and the client IP address.

#### Request
GET / \
Host: localhost:8080

#### Response
{\
  "timestamp": "2025-05-17T15:04:05.123Z",\
  "ip": "192.168.1.10"\
}

#### Response Codes
200 OK  – Successful response.

500 Internal Server Error – If something goes wrong on the server.


## Prerequisites
- Java 17+
- Maven 3.9+
- Spring 3.x +
- Docker
- Kubernetes
- Terraform
- AWS CLI
- Eclipse IDE
- VS Code
## Run Locally

Clone the project

```bash
  git clone https://github.com/Rushi247/SimpleTimeService.git
```

Go to the project directory

```bash
  cd SimpleTimeService
```

Build the project

```bash
  mvn clean package
```

Run the Spring boot application

```bash
  mvn spring-boot:run
```
Access the service at: http://localhost:8080/

## Docker Instructions
Ensure you have Docker installed.

Build Docker Image

```bash
  docker build -t simple-time-service .
```
Run Docker Container

```bash
  docker run -p 8080:8080 simple-time-service
```
## Terraform Setup for AWS Deployment
Ensure you have:
- AWS CLI configured (aws configure)
- An AWS IAM user with sufficient permissions
- Terraform installed
#### AWS CLI Configuration

```bash
  aws configure
  # Provide your:
  # - AWS Access Key ID
  # - AWS Secret Access Key
  # - Default region name (e.g., us-east-1)
  # - Output format (e.g., json)
```
#### Terraform Steps
Initialize Terraform
```bash
terraform init
```
Preview Infrastructure Plan
```bash
terraform plan
```
Apply Infrastructure Changes
```bash
terraform apply
```


## Documentation
Refer this document for step-by-step process for application running and deployment. \
[Documentation](https://1drv.ms/w/c/688fa2d92cc7ed6a/EX3O_21PSKxEmMdUtNybIyYBnraGpSLiPytNAtdP7q-2VA?e=5SARuM)


