# Project Overview for MERN Stack Deployment on AWS with Terraform and Ansible

This project involves deploying a MERN (MongoDB, Express.js, React.js, Node.js) stack application on AWS. The infrastructure setup is managed by Terraform, which provisions and configures AWS resources, while Ansible is used for application configuration and deployment tasks.

## Link to the GitHub repository for the MERN application:
https://github.com/UnpredictablePrashant/TravelMemory


## Infrastructure Setup with Terraform

### Components:

- **VPC (Virtual Private Cloud)**: Serves as the isolated network for running AWS resources.
- **Subnets**: Public and private subnets handle traffic routing to the Internet and internally within AWS.
- **Internet Gateway & NAT Gateway**: Provide Internet access to instances in public and private subnets.
- **EC2 Instances**: Serve as virtual servers for running the application's web and database components.
- **Security Groups**: Define the ingress and egress rules for traffic to and from EC2 instances.

### Process:

- **Initialization (`terraform init`)**: Prepares the Terraform environment by downloading necessary providers and initializing the backend.
- **Planning (`terraform plan`)**: Generates an execution plan, allowing for a preview of the actions Terraform will perform.
- **Application (`terraform apply`)**: Executes the plan to create the infrastructure, setting up all the components listed above.

## Configuration and Deployment with Ansible

### Components:

- **Web Server Configuration**: Sets up Node.js and related dependencies on EC2 instances designated for web server roles.
- **Database Server Configuration**: Installs and configures MongoDB on designated EC2 instances for database roles.
- **Application Deployment**: Deploys the application code, configuring environment variables and starting the application services.

### Process:

- **Inventory Setup**: Updates the inventory.ini file to specify the hosts, their roles, and connection details.
- **Playbook Execution**:
  - **Web Server Setup (`ansible-playbook web-server.yaml`)**: Runs tasks to configure the web server environment.
  - **Database Server Setup (`ansible-playbook db-server.yaml`)**: Runs tasks to prepare the database environment.
  - **Application Deployment (`ansible-playbook deploy.yaml`)**: Deploys application code and starts services.

## Interactions Between Components

- **React.js Frontend**: Runs in users' browsers, makes API calls to the Express.js backend hosted on AWS EC2.
- **Express.js Backend**: Hosted on EC2, handles API requests, interacts with MongoDB for data retrieval and storage, and serves the static files for the frontend.
- **MongoDB Database**: Also hosted on EC2 within private subnets, interacts only with the backend component for security.

## Security and Monitoring

- **Security Groups**: Ensure that only appropriate ports are open (e.g., HTTP/HTTPS for web servers, MongoDB port only from web servers).
- **Ansible Security Hardening**: Additional tasks may include setting up firewalls, configuring SSL/TLS, and hardening SSH access.
- **Monitoring**: AWS CloudWatch monitors instance performance and logs system events. Ansible can configure additional monitoring tools like Prometheus or Grafana for application-level metrics.

## Backup

- **Backup**: Terraform state files are backed up in S3, ensuring recoverability. Database backups are handled via MongoDB tools and stored securely.



## Prerequisites

- Install Terraform: [Download & Install Terraform](https://www.terraform.io/downloads.html)
- Install Ansible: [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Configure the AWS CLI: Follow [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) to set up your AWS credentials.



## File Structure Overview

### /ansible
- `ansible.cfg`: Configuration file for Ansible settings.
- `db-server.yaml`: Ansible playbook for setting up the database server.
- `deploy.yaml`: Ansible playbook for deploying the application.
- `inventory.ini`: Inventory file listing hosts and their configurations.
- `security.yaml`: Ansible playbook for implementing security hardening measures.
- `web-server.yaml`: Ansible playbook for setting up the web server.

### /terraform
- `.terraform.lock.hcl`: Terraform lock file to ensure provider consistency.
- `main.tf`: Main Terraform configuration file defining resource provisioning.
- `outputs.tf`: Defines output variables from Terraform provisioning.
- `terraform.tfvars`: Contains variable values for Terraform configurations.
- `variables.tf`: Defines variables used across Terraform configurations.

### /terraform/.terraform
- `terraform.tfstate`: Terraform state file, storing state management information.

### /terraform/.terraform/modules
- `modules.json`: JSON file listing metadata about used modules.

### /terraform/modules (Subdirectories per module, each containing):
- `main.tf`: Main Terraform configuration for the specific module.
- `outputs.tf`: Output variables specific to the module.
- `variables.tf`: Variables specific to the module.

#### Submodules:
- **ec2**
  - Responsible for provisioning EC2 instances.
- **nat-gateway**
  - Sets up a NAT gateway for outbound internet access from private subnets.
- **security-group**
  - Configures security groups for resource access control.
- **subnet**
  - Manages subnet configuration within the VPC.
- **vpc**
  - Defines and configures a Virtual Private Cloud (VPC).



## Update below iles for Ansible configurations:

### Inventory.ini
Update Public IP Addresses: Replace placeholders with actual EC2 instance IPs.
Configure SSH Key: Ensure ansible_ssh_private_key_file points to your SSH private key's correct path.

### Ansible.cfg
Private Key File: Set private_key_file to the path of your private SSH key for default usage.

### Deploy.yaml
Set Database Credentials: Update DB_USER and DB_PASS to the actual database credentials, ensuring secure storage (possibly using Ansible Vault).



## Step 1: Deploy Infrastructure with Terraform

### Navigate to Your Terraform Directory
```bash
cd path/to/your/terraform/directory
```

### Initialize Terraform
Prepare the Terraform environment by initializing it, which will download the necessary plugins.
```bash
terraform init
```

### Plan Terraform Deployment
Review the resources that Terraform plans to create. This step helps identify any potential issues before the actual deployment.
```bash
terraform plan
```

### Apply Terraform Configuration
Execute the plan to deploy your infrastructure on AWS.
```bash
terraform apply
```
Type `yes` when prompted to proceed.

### Retrieve Outputs
After deployment, retrieve outputs such as EC2 public IPs which will be used in the Ansible inventory.
```bash
terraform output
```



## Step 2: Configure and Deploy with Ansible

### Update Ansible Inventory
Edit your `inventory.ini` file to include the public IP addresses of your EC2 instances under the appropriate groups (`web_servers` for Node.js servers, `db_servers` for MongoDB servers).

### Navigate to Your Ansible Directory
```bash
cd path/to/your/ansible/directory
```

### Run Ansible Playbooks
#### Web Server Setup
```bash
ansible-playbook -i inventory.ini web-server.yaml
```

#### Database Server Setup
```bash
ansible-playbook -i inventory.ini db-server.yaml
```

#### Deploy the Application
Run this playbook if you have a separate playbook for deploying the application. Ensure that your previous playbooks handle the deployment process correctly.
```bash
ansible-playbook -i inventory.ini deploy.yaml
```

#### Security Hardening (Optional)
Execute additional playbooks prepared for security hardening.
```bash
ansible-playbook -i inventory.ini security.yaml
```



## Step 3: Verify Deployment

### Check Application Status
Access your web server using its public IP or domain name (if configured) to ensure the application is running and can connect to the database.

### Monitor Logs
Check logs for any errors or warnings that might indicate issues with the setup.
```bash
journalctl -u your-web-service-name
```

### Perform Functional Tests
Run any prepared test scripts or manually test the application functionality to ensure everything is working as expected.
