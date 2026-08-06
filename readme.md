# AWS Three-Tier Web Application with CI/CD

## Project Overview

This project deploys a three-tier web application on AWS using
Terraform.

The application includes:

-   React frontend
-   Node.js backend
-   MySQL RDS database

The infrastructure includes:

-   VPC
-   Public and private subnets
-   Application Load Balancer (ALB)
-   Auto Scaling Group (ASG)
-   EC2 instances
-   Amazon RDS
-   IAM Roles
-   Security Groups
-   AWS Systems Manager (SSM)

The application is deployed using AWS CodePipeline, CodeBuild and
CodeDeploy.

------------------------------------------------------------------------

# AWS Services Used

-   Amazon VPC
-   Amazon EC2
-   Application Load Balancer
-   Auto Scaling Group
-   Amazon RDS (MySQL)
-   IAM
-   AWS Systems Manager
-   CodePipeline
-   CodeBuild
-   CodeDeploy
-   CloudWatch

------------------------------------------------------------------------

# Project Structure

``` text
.
├── env/
├── modules/
├── api/
├── frontend/
├── scripts/
├── appspec.yml
├── buildspec.yml
├── docker-compose.prod.yaml
├── README.md
```
------------------------------------------------------------------------

# Deploy Infrastructure

Go to the environment folder.

``` bash
cd env/dev
```

Initialize Terraform.

``` bash
terraform init
```

Check the plan.

``` bash
terraform plan
```

Create the infrastructure.

``` bash
terraform apply
```

Terraform creates:

-   VPC
-   ALB
-   ASG
-   EC2
-   RDS
-   Security Groups
-   IAM Roles
-   CloudWatch resources
-   CI/CD resources

------------------------------------------------------------------------

# CI/CD Flow

1.  Push code to the **main** branch.
2.  CodePipeline starts automatically.
3.  CodeBuild validates the project.
4.  CodeDeploy deploys the application to the EC2 instances.
5.  Docker starts the frontend and backend containers.

------------------------------------------------------------------------

# Verify Deployment

Open the ALB URL in your browser.

Check:

-   Frontend loads.
-   Backend API works.
-   Database connection works.

------------------------------------------------------------------------

# Monitoring

CloudWatch is used for:

-   EC2 monitoring
-   RDS monitoring
-   Dashboard
-   Alarms

------------------------------------------------------------------------

# Screenshots

Create a folder named **Screenshots** and include:

-   terraform-apply.png
-   running-application.png
-   pipeline-success.png
-   cloudwatch-dashboard.png
-   cloudwatch-alarms.png

------------------------------------------------------------------------

# Cleanup

To remove all AWS resources:

``` bash
terraform destroy
```

------------------------------------------------------------------------

# Repository

Repository:

``` text
https://github.com/verma1711/new_task
```

Application URL:

``` text
http://<ALB-DNS-NAME>
```

Replace `<ALB-DNS-NAME>` with your Application Load Balancer DNS name.

------------------------------------------------------------------------

# Notes

-   EC2 instances are deployed in private subnets.
-   Access to EC2 is through AWS Systems Manager (SSM).
-   Docker is used to run the frontend and backend.
-   Terraform modules are used to keep the code simple and reusable.
-   Different environments can be managed using separate tfvars files.
