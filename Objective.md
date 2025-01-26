
# Deploying MERN Stack on AWS with Terraform and Ansible

This project aims to provide practical experience in deploying a MERN stack application on AWS, using Terraform for infrastructure automation and Ansible for configuration management.

## Objective

Gain hands-on experience deploying a MERN stack application on AWS with Terraform and Ansible to understand infrastructure as code and automation processes in a cloud environment.

## Application Source

The MERN application used in this project is available at:
[TravelMemory](https://github.com/UnpredictablePrashant/TravelMemory)

## Project Tasks

### Part 1: Infrastructure Setup with Terraform

#### Task 1: AWS Setup and Terraform Initialization

- **AWS CLI Configuration**: Authenticate with your AWS account.
- **Terraform Project Initialization**: Initialize a Terraform project targeted for AWS.

#### Task 2: VPC and Network Configuration

- **VPC Creation**: Set up an AWS VPC with two subnets, one public and one private.
- **Gateway Configuration**: Establish an Internet Gateway and a NAT Gateway.
- **Route Tables**: Configure route tables for both subnets.

#### Task 3: EC2 Instance Provisioning

- **EC2 Instances**: Launch two EC2 instances; one in the public subnet for the web server and another in the private subnet for the database.
- **SSH Access**: Ensure both instances are accessible via SSH, with the public instance only accessible from your specified IP.

#### Task 4: Security Groups and IAM Roles

- **Security Groups**: Create necessary security groups for the web server and the database server.
- **IAM Roles**: Assign appropriate IAM roles to EC2 instances with the necessary permissions.

#### Task 5: Resource Output

- **Outputs**: Display the public IP of the web server EC2 instance.

### Part 2: Configuration and Deployment with Ansible

#### Task 1: Ansible Configuration

- **Ansible Setup**: Configure Ansible to manage AWS EC2 instances.

#### Task 2: Web Server Setup

- **Node.js and NPM Installation**: Use an Ansible playbook to install Node.js and NPM on the web server.
- **Repository Cloning and Dependency Installation**: Clone the MERN application repo and install its dependencies.

#### Task 3: Database Server Setup

- **MongoDB Installation**: Install and configure MongoDB on the database server.
- **Database Security**: Secure the MongoDB instance and create required users and databases.

#### Task 4: Application Deployment

- **Environment Setup**: Configure necessary environment variables.
- **Start Application**: Launch the Node.js application ensuring the React frontend can communicate with the Express backend.

#### Task 5: Security Hardening

- **Security Enhancements**: Harden security by configuring firewalls and security groups.
- **Additional Security Measures**: Implement further security measures like SSH key pairs and disable root login.

## Conclusion

This project demonstrates the effective use of Terraform and Ansible to deploy a MERN stack application on AWS, emphasizing best practices in cloud infrastructure and configuration management.
