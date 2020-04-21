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
## s3
Creates an S3 bucket.

```hcl-terraform
module "s3" {
  source = "github.com/will-goodman/aws-terraform-modules//s3"
  
  bucket_name = // Name for the S3 bucket. Must be globally unique
  bucket_policy = // Bucket policy to apply to the bucket
  
  force_destroy = // Whether or not to forceably destroy the bucket's contents on a terraform destroy. Default false
  versioning = // Whether or not to enable bucket versioning. Defaults to false
  region = // Region to create the bucket in
}
```

Outputs:
- id
- arn

## self_signed_cert
Creates a TLS self-signed x509 certificate. 
<br><b>ONLY USE IN DEV ENVIRONMENTS</b>
<br>This module uses the tls_private_key resource which stores the unencrypted key in the state file. As such, this module should only be used in Dev environments.
- Self-signed certificate in Amazon Certificate Manager

```hcl-terraform
module "self_signed_cert" {
  source = "github.com/will-goodman/aws-terraform-modules//self_signed_cert"

  key_algorithm = // Key algorithm to use to generate the private key.

  common_name = // Domain to create the certificate for.

  validity_hours = // How many hours the certificate should remain valid.

  allowed_uses = // List of reasons the certificate can be used. See https://www.terraform.io/docs/providers/tls/r/self_signed_cert.html
}
```

Outputs:
- arn (of the certificate in ACM)

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

