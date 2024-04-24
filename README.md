#### Author: Aamir Shehzad
#### Email: aamir.shehzad3346875@gmail.com

# Application Deployment Guide

This guide provides instructions for deploying the necessary infrastructure for our application using Terraform, installing Redis and MySQL with Helm, and deploying the application itself via a Helm chart. Our CI/CD pipeline ensures that tests are run, the Docker image is built and pushed to Amazon ECR, and finally, the application is deployed using Helm.

## Prerequisites
- AWS CLI, configured with appropriate access
- Docker, for building and pushing images
- Helm 3, for deploying charts
- Terraform, for provisioning infrastructure
- kubectl, configured to interact with your Kubernetes cluster
- Infrastructure Setup with Terraform
- Redis helm chart installed as we need redis to run our app.
- Mysql helm chart installed as we need mysql db for app.

Navigate to your Terraform configuration directory and run:

    terraform init

Apply Terraform Configuration:
Review the plan and apply the configuration:

    terraform apply

Confirm the apply when prompted.

## Installing Redis and MySQL with Helm
Ensure you have added the Bitnami charts repository to Helm:

    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update


Deploy Redis
To install Redis into the redis namespace, run:

    helm install redis bitnami/redis -n redis --create-namespace

Deploy MySQL
To install MySQL into the mysql namespace, run:


    helm install mysql bitnami/mysql -n mysql --create-namespace


## CI/CD Pipeline
Our CI/CD pipeline consists of the following steps:

1. Run Tests
Before deploying the application, automated tests are run to ensure reliability and stability.

To run tests:

    make test

2. Build and Push Docker Image to Amazon ECR
Assuming you have a Dockerfile in your repository root, use the following commands:

### Build the Docker image
    docker build -t boilerplate .

### Tag the image for Amazon ECR
    docker tag my-application:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/boilerplate:$IMAGE_TAG

### Push the image to Amazon ECR
    docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/boilerplate:$IMAGE_TAG

3. Deploy Application with Helm
Replace the placeholders in your application's Helm chart values with the image URI from Amazon ECR, then deploy your application to Kubernetes.


### Deploy the application using Helm
    helm upgrade --install boilerplate ./helm-chart/laravel-10-boilerplate -n app --set app.container.image=$ECR_REPOSITORY:$IMAGE_TAG --create-namespace


### Additional Information
Redis and MySQL: The Helm commands will install Redis and MySQL with default settings. For production deployments, review and customize the configurations according to your needs.
Security: Ensure your AWS permissions and Kubernetes RBAC policies are correctly configured for your deployment scenario.


## Additional Questions Answers

Write ways to improve Dockerfile security?

- Use official images.
- Regularly updates images.
- Use multistage build.
- Run as non-root user
- Scan images for vulnerabilities.
- Minimize layers and build context.
- Sign and verify images.


Write a way to create another Kubernetes Deployment process without using helm chart?

- We can use kustomize to deploy manifests file.
- We can also use slaffold to deploy k8s manifests.