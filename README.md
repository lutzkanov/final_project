# Overview

This project is a simple static website deployment pipeline using GitHub Actions, AWS S3, Docker, and Terraform. 
It could be improved by using an EC2 instance and nginx (for example) instead of an S3 bucket, but I want to keep it more simple for now. 
For convenience, the website can be accessed trough my custom domain, which I have set up to redirect to the S3 bucket URL: https://iambatman.icu


## Technologies Used
- **GitHub Actions** for Continuous Integration and Delivery (CI/CD).
- **AWS S3** for hosting the static website.
- **Terraform** for Infrastructure as Code (IaC).
- **Docker** for containerizing the Terraform environment.
- **GitHub** as the source control platform.
- **CloudFlare** for DNS management and CDN services.
- **GitHub Secrets** for managing sensitive information.

# Topics Covered in the Project

## 1. Source Control (GitHub)
- Version control using GitHub to manage source code and track changes.
- Utilized GitHub repositories for storing the website's source code (HTML, CSS, JS).

## 2. Continuous Integration (CI) (GitHub Actions)
- Implemented GitHub Actions for continuous integration.
- Automated testing and linting of code changes.
- Triggered builds and deployments through pull requests and pushes to specific branches.

## 3. Continuous Delivery (CD) (GitHub Actions)
- Set up continuous delivery pipelines in GitHub Actions for automated deployments.
- Deployed the static website to AWS S3 every time changes are pushed to the main branch.

## 4. Infrastructure as Code (Terraform)
- Utilized Terraform to define infrastructure for AWS S3 buckets and Cloudflare.
- Infrastructure managed and provisioned automatically through Terraform configurations.

## 5. Configuration Management (Using Docker)
- Used Docker to containerize the Terraform environment, ensuring consistency across systems and environments.
- This makes it easy to run Terraform commands in any environment, ensuring that infrastructure is provisioned consistently.

## 6. Security (Secrets management)
- Used GitHub Secrets, planning to implement HashiCorp Vault.
- Kept AWS credentials and other secrets secure and dynamic, avoiding hardcoding sensitive data.

## 7. Immutable Infrastructure (Using Terraform to deploy infrastructure)
- Practiced immutable infrastructure by defining infrastructure as code with Terraform.
- Every deployment was treated as a fresh deployment, ensuring consistency and avoiding configuration drift.

## 8. Collaboration (GitHub Actions & Pull Requests)
- Used GitHub Pull Requests for collaboration and code review.
- Integrated GitHub Actions to automatically trigger builds and tests when PRs are created or updated.

## 9. Observability (Logs from Terraform and CI/CD pipeline)
- Implemented observability in the CI/CD pipeline by logging Terraform execution and actions from GitHub Actions.
- Ensured visibility into the pipeline execution status and any issues that may arise.

## 10. Deployment (S3 + Terraform deployment)
- Automated the deployment of a static website to AWS S3 using Terraform.
- Configured AWS S3 for static website hosting, including setting up permissions and policies for public access.