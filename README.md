# Terraform AWS Resources

This folder contains Terraform configuration files to create AWS resources.

## Prerequisites

[Video]()

Before you can use these Terraform files, make sure you have the following prerequisites installed:

- Terraform (version X.X.X)
- AWS CLI (version X.X.X)
- AWS account credentials

## Usage

1. Clone this repository to your local machine.
2. Navigate to the `terraform` folder.
3. Initialize Terraform by running the following command:
    ```
    terraform init
    ```
4. Modify the `variables.tf` file to customize the resource settings.
5. Review the `main.tf` file to understand the resources that will be created.
6. Run the following command to preview the changes:
    ```
    terraform plan
    ```
7. If the plan looks good, apply the changes by running:
    ```
    terraform apply
    ```
8. Confirm the changes by typing `yes` when prompted.
9. Wait for Terraform to provision the resources.
10. Once the resources are created, you can verify them in your AWS account.

## Clean Up

To clean up the resources created by Terraform, run the following command: `terraform destroy`