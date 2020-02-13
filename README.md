# aws-terraform-modules
Terraform modules for AWS infrastructure.

## bootstrap
Creates the resources required to store the Terraform state in AWS.
- S3 bucket to store the terraform state file
- DynamoDB table to store the state lock

```hcl-terraform
module "bootstrap" {
  source = "github.com/will-goodman/aws-terraform-modules//bootstrap"

  state_bucket_name = //Globally unique name for the bucket which stores the Terraform state.
  lock_table_name = //Name of the DynamoDB table which stores the state file lock.
}
```

## vpc
Creates resources required for VPC networking.
- VPC
- Two private subnets
- Two public subnets
- NAT Gateway
- Internet Gateway

```hcl-terraform
module "vpc" {
  source = "github.com/will-goodman/aws-terraform-modules//vpc"
  
  vpc_name = //Name to assign to the VPC.
  
  vpc_cidr = //CIDR range of the VPC.
  availability_zones = //List of availability zones to deploy subnets to. Must be at least two.
  public_cidr_range = //CIDR range of the public subnet.
  second_public_cidr_range = //CIDR range of the second public subnet.
  private_cidr_range = //CIDR range of the private subnet.
  second_private_cidr_range = //CIDR range of the second private subnet.
}
```

Outputs:
- vpc_id
- public_subnets (Subnet IDs)
- private_subnets (Subnet IDs)

## vpc_lambda
Creates a Lambda hosted within a VPC.
- Lambda
- CloudWatch Log Group (for the Lambda)
- IAM role for the Lambda

```hcl-terraform
module "lambda" {
  source = "github.com/will-goodman/aws-terraform-modules//vpc_lambda"
  
  function_name = //Name of the lambda function.
  lambda_handler = //Path to the lambda handler in the deployment package e.g. /directory/file.main
  logs_retention_period = //Length of time to retain the CloudWatch logs of the lambda in days.

  memory_size = //Memory size to allocate to the lambda in MB.
  timeout = //Timeout period for the lambda in seconds.
  runtime = //Runtime environment for the lambda.

  filename = //Path to the zip file containing the deployment package.

  subnet_ids = //Subnets to give the lambda access to. List.
  security_groups = //Security groups to place the lambda in. List.
}
```

Outputs:
- arn (of the Lambda function)

