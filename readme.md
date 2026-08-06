# AWS Three-Tier Web Application with CI/CD

## Project Overview

This project deploys a three-tier web application on AWS using Infrastructure as Code with Terraform.

The application consists of:

- React frontend
- Node.js backend
- MySQL RDS database

The infrastructure includes:

- VPC with public and private subnets
- Application Load Balancer
- Auto Scaling Group
- EC2 instances
- Amazon RDS
- IAM roles
- Security Groups

The application is deployed automatically using AWS CodePipeline, CodeBuild, and CodeDeploy. Docker is used to build and run the application containers.