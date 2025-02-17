
# Stage 1: Build stage
FROM ubuntu:latest AS terraform-builder

# Accept build arguments
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

# Set environment variables
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}


# Install necessary tools for Terraform
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    bash \
    ca-certificates && \
    echo "Installing Terraform CLI..." && \
    curl -LO https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip && \
    unzip terraform_1.4.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.4.6_linux_amd64.zip && \
    echo "Terraform CLI installation completed."

# Stage 2: Final image
FROM ubuntu:latest

# Install necessary tools (bash, curl, ca-certificates, unzip)
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    ca-certificates \
    unzip \
    wget && \
    echo "Dependencies installed."

# Copy Terraform binaries from the builder stage
COPY --from=terraform-builder /usr/local/bin/terraform /usr/local/bin/terraform

RUN echo "Terraform binary copied."

# Set environment variables for AWS (using Dockerfile's ENV command)
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} 
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_REGION=${AWS_DEFAULT_REGION}

# Copy the necessary files for your deployment
COPY ./main.tf /app/
COPY ./quizz-app /app/quizz-app/
RUN echo "Terraform configuration and website files copied to container."

# Set the working directory to where your Terraform files are located
WORKDIR /app
RUN echo "Working directory set to /app."

RUN echo "Running Terraform..." && \
    terraform init && \
    terraform apply -auto-approve \
    -var "access_key=${AWS_ACCESS_KEY_ID}" \
    -var "secret_key=${AWS_SECRET_ACCESS_KEY}" && \
    echo "Terraform apply completed."
