# terraform-redis-enterprise-cluster-aws

Build and deploy an AWS Redis Enterprise Cluster, create and join cluster, run memtier benchmark and export json to S3.

- Create VPC
    - subnet, internet gateway, security group, route table
        - Create elastic ips
        - Create 3 EC2 instances from AWS marketplace AMI for Redis Enterprise
            - associate elastic ip public address with EC2s
        - Using existing DNS hostname (hostname id required) create A records and NS records
            - (with the EC2 associated elastic ip addresses)
        - Create EC2 and install memtier_benchmark
            - run Redis Enterprise REST API curl commands to:
                - create cluster
                - join cluster
                - create db
                    - run memtier benchmark commands on created redis enterprise db
                        - export json to generated S3.

## Prerequisites:

Terraform installed and an AWS account.

1. AWS credentials
    - AWS access key and AWS secret key
2. AWS ssh key
3. working DNS hosted zone
    - require the id (you can find it in R53 hosted zones)

## Getting started

```bash
  git clone https://github.com/bpamos/terraform-redis-enterprise-cluster-aws
  cd terraform-redis-enterprise-cluster-aws
  terraform init
```
The output should include:
```text
  Terraform has been successfully initialized!
```
Copy the variables template.
```bash
cp terraform.tfvars.example terraform.tfvars
```
Update terraform.tfvars with your [AWS creds, AWS ssh key, DNS hosted zone id, and other variables]
```bash
terraform plan
terraform apply
```

Go access your Redis Cluster from the FQDN.
- you can find the cluster FQDN and username and password in the outputs.
```bash
  RedisEnterpriseClusterFQDN     = "https://redisuser1-tf-us-east-1.redisdemo.com:8443/"
  RedisEnterpriseClusterPassword = "123456"
  RedisEnterpriseClusterUsername = "demo@redislabs.com"
```

## Cleanup

Remove the resources that were created. (BE SURE TO GO AND DELETE THE JSON FILE FROM YOUR S3 BUCKET)

```bash
terraform destroy
```
