# Stage 1: Build stage
FROM ubuntu:latest AS terraform-builder

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

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    ca-certificates \
    unzip \
    wget && \
    echo "Dependencies installed."

# Copy Terraform binaries from the builder stage
COPY --from=terraform-builder /usr/local/bin/terraform /usr/local/bin/terraform


COPY ./main.tf /app/
COPY ./quizz-app /app/quizz-app/

WORKDIR /app

CMD ["sh", "-c", "terraform init && terraform apply -auto-approve"]
