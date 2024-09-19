# Data Engineering Project Starter Kit

This README provides instructions for setting up the infrastructure for our data engineering project. We'll be using Docker for containerization and Terraform for infrastructure as code.

## Prerequisites

[Data Camping Infrastructure](https://de-book.longdatadevlog.com/datacamping/week_1_basics_and_infrastructure/index.html)

Before you can use these Terraform files, make sure you have the following prerequisites installed:

- Git
- Docker and Docker Compose
- Terraform
- AWS CLI (configured with your credentials)


## Docker Setup

Change directory to the `local-xx-compose` folder and run the following command:

1. Install Docker:
   - For macOS and Windows: Download and install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)
   - For Linux: Follow the instructions for your specific distribution on [docs.docker.com](https://docs.docker.com/engine/install/)

2. Verify Docker installation:
   ```
   docker --version
   docker-compose --version
   ```

3. Build and run the Docker containers:
   ```
   docker-compose up -d
   ```

4. Verify the containers are running:
   ```
   docker-compose ps
   ```

## Terraform Setup

Change directory to the `terraform` folder and run the following command:

1. Install Terraform:
   - Visit [terraform.io](https://www.terraform.io/downloads.html) and download the appropriate package for your operating system
   - Extract the downloaded file and move the `terraform` binary to a directory in your system PATH

2. Verify Terraform installation:
   ```
   terraform --version
   ```

3. Initialize Terraform:
   ```
   cd terraform
   terraform init
   ```

4. Review and modify the Terraform configuration files (`main.tf`, `variables.tf`, etc.) as needed for your project.

5. Plan the infrastructure changes:
   ```
   terraform plan
   ```

6. Apply the infrastructure changes:
   ```
   terraform apply
   ```

   When prompted, type `yes` to confirm the changes.

7. After Terraform completes, it will display the outputs. Make note of any important information, such as endpoint URLs or resource IDs.

## Next Steps (Data Camping Practice)

[Data Camping Practice](https://de-book.longdatadevlog.com/datacamping/week_1_basics_and_infrastructure/index.html)

- Configure your data pipelines and ETL processes within the Docker containers.
- Set up monitoring and logging for your infrastructure and applications.
- Implement CI/CD pipelines for automated deployment of infrastructure changes and application updates.

## Clean Up

To clean up the resources created by Terraform, run the following command: `terraform destroy`

## Troubleshooting

- If you encounter issues with Docker, check the Docker logs:
  ```
  docker-compose logs
  ```

- For Terraform issues, use the `terraform show` command to inspect the current state, and `terraform refresh` to reconcile the state with the actual infrastructure.

## Contributing

Please read our CONTRIBUTING.md file for details on our code of conduct and the process for submitting pull requests.
