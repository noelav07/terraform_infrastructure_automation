# Terraform Infrastructure Automation

A modular Terraform configuration for deploying a highly available web application infrastructure on AWS using GitHub VCS integration with Terraform Cloud.

## Project Overview

This project demonstrates Infrastructure as Code (IaC) mastery using Terraform and Terraform Cloud for automated AWS infrastructure deployment. The entire infrastructure is managed through GitHub VCS integration, showcasing modern DevOps practices and cloud automation.

## Architecture

The project creates a production-ready, highly available web application infrastructure on AWS:

- **VPC** with public subnets across multiple Availability Zones
- **EC2 Instances** (2 instances) running Apache web servers with auto-configuration
- **Application Load Balancer** for traffic distribution and health monitoring
- **Security Groups** with controlled ingress/egress rules
- **SSH Key Management** for secure instance access

### High Availability Design
- Multi-AZ deployment across az's
- Load balancing with health checks
- Fault tolerance with automatic failover
- User data scripts for consistent server configuration


##  Workflow

### GitHub + Terraform Cloud Integration
1. **Code Push**: Changes pushed to GitHub repository
2. **Auto-Trigger**: Terraform Cloud detects changes via VCS webhook
3. **Plan Generation**: Automatic `terraform plan` execution
4. **Approval**: Manual approval for production deployments
5. **Apply**: Automated `terraform apply` execution
6. **State Update**: Remote state automatically updated

## Technical Implementation

### Modular Architecture
- **VPC Module**: Handles networking infrastructure (VPC, subnets, IGW, routing)
- **EC2 Module**: Manages compute resources (instances, key pairs)
- **Main Configuration**: Orchestrates modules and defines load balancer

### Infrastructure Components
- Custom VPC with DNS support and hostnames
- Public subnets across multiple AZs for high availability
- Application Load Balancer with health checks
- Automated Apache web server configuration

## Deployment Instructions

### Terraform Cloud Setup

1. **Create Terraform Cloud Workspace**
   - Connect to GitHub repository
   - Configure VCS-driven workflow
   - Set up environment variables

2. **Configure Environment Variables**
   ```
   AWS_ACCESS_KEY_ID = "your-access-key"
   AWS_SECRET_ACCESS_KEY = "your-secret-key"
   AWS_DEFAULT_REGION = "ap-south-1"
   ```

3. **Set Terraform Variables**
   | Variable | Type | Value | Description |
   |----------|------|-------|-------------|
   | `vpc_cidr` | string | `"10.0.0.0/16"` | VPC CIDR block |
   | `subnet1_cidr` | string | `"10.0.1.0/24"` | First subnet CIDR |
   | `subnet2_cidr` | string | `"10.0.2.0/24"` | Second subnet CIDR |
   | `availability_zones` | list(string) | `["ap-south-1a", "ap-south-1b"]` | AZs for subnets |
   | `ami_id` | string | `"ami-0261755bbcb8c4a84"` | Amazon Linux 2023 AMI |
   | `instance_type` | string | `"t2.micro"` | EC2 instance type |
   | `key_name` | string | `"vpc1_key"` | SSH key pair name |
   | `public_key` | string | `"ssh-rsa AAAAB3..."` | SSH public key |
   | `instance_count` | number | `2` | Number of EC2 instances |

4. **Deploy Infrastructure**
   - Push code to GitHub
   - Terraform Cloud automatically triggers deployment
   - Monitor deployment progress in Terraform Cloud UI
   - Access application via ALB DNS name

## Project Outputs

After successful deployment:
- **ALB DNS Name**: Access point for the web application
- **EC2 Instances**: 2 instances running Apache web servers
- **VPC Resources**: Custom VPC with public subnets and routing
- **Load Balancer**: Health-checked traffic distribution

## Infrastructure Management

### Updating Infrastructure
1. Modify Terraform code
2. Push changes to GitHub
3. Terraform Cloud auto-triggers plan
4. Review and approve changes
5. Apply updates automatically

### Destroying Resources
1. Navigate to Terraform Cloud workspace
2. Queue destroy plan
3. Confirm destruction
4. Monitor cleanup progress
