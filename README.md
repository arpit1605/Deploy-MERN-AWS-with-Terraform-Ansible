# MERN Stack Deployment on AWS with Terraform and Ansible

This guide describes the process of deploying a MERN stack application on AWS using Terraform for infrastructure management and Ansible for application configuration and deployment.


## Link to the GitHub repository for the MERN application:
https://github.com/UnpredictablePrashant/TravelMemory


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
