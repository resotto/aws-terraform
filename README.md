<h1 align="center">aws-terraform</h1>

<p align="center">
  <a href="https://twitter.com/_resotto_"><img src="https://img.shields.io/badge/feedback-@_resotto_-blue.svg" /></a>
  <a href="https://github.com/resotto/aws-terraform/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-GPL%20v3.0-brightgreen.svg" /></a>
</p>

<p align="center">
  AWS with Terraform rocket start guide.
</p>

<p align="center">
  <img src="https://raw.github.com/wiki/resotto/aws-terraform/img/aws-terraform.png">
</p>

---
This guide is for who is new to Terraform.  
Following this guide, you can learn how to operate Terraform commands.

**NOTE**
- This guide doesn't cost at all now (2019/8/6), but in the future, that might just be the case.   Even if that happens, it wouldn't cost 1 sandwich.
---

## Infrastructure
On this guide, you can build following infrastructure with AWS and Terraform:
<p align="center">
  <img src="https://raw.github.com/wiki/resotto/aws-terraform/img/infrastructure.png">
</p>

## Requirements

### AWS, AWS CLI, and Terraform
At first, please sign up AWS, and install AWS CLI and Terraform:
- [AWS](https://portal.aws.amazon.com/billing/signup#/start)
- [AWS CLI](https://docs.aws.amazon.com/en_us/cli/latest/userguide/install-macos.html)
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

Then, please create your IAM user according to [this guide](https://docs.aws.amazon.com/en_us/IAM/latest/UserGuide/id_users_create.html).

After creating IAM user, please set your aws credentials and config with following command:
```
aws configure
```
You need to specify your IAM user's key info, your region, and output format.
```
AWS Access Key ID [None]: XXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXX
Default region name [None]: us-west-1
Default output format [None]: json
```
If you change your IAM user, please run `aws configure` again, and set your new credentials.

### Key Pair
If you don't have key pair like `id_rsa` and `id_rsa.pub` on your local machine, please run `ssh-keygen` command:
```
ssh-keygen -t rsa
```
This command will ask you some questions about where to save and passphrase, but on this guide you don't have to specify them.
```
Enter file in which to save the key (/Users/USERNAME/.ssh/id_rsa): [enter]
Enter passphrase (empty for no passphrase): [enter]
Enter same passphrase again: [enter]
```
Please confirm key pair created.
```
Your identification has been saved in /Users/USERNAME/.ssh/id_rsa.
Your public key has been saved in /Users/USERNAME/.ssh/id_rsa.pub.
```


## Getting Started
### Preparation
```
git clone git@github.com:resotto/aws-terraform.git
cd aws-terraform
```

First of all, if your public key is not located at `~/.ssh/id_rsa.pub`, you need to fix path in `./modules/key_pair/key_pair.tf`:
```
public_key = "${file("~/.ssh/id_rsa.pub")}"
```

Please move to `env/prod` or `env/dev`.  
```
cd env/prod [env/dev]
```
Actually, there are no differences between prod and dev except for naming on this guide.
In business, you can adopt different configuration between them.


Please fix region and AMI based on the region in `./variables.tf`:
```
variable "region" {
  default = "ap-northeast-1" // fix this
}

variable "amis" {
  type = "map"
  default = {
    "ap-northeast-1" = "ami-0c3fd0f5d33134a76" // fix this
  }
}
```

### Running Terraform
Please run following commands:
```
terraform init
terraform get -update
terraform plan
terraform apply
```

Let's check Elastic IP of the instance with `terraform show`:
```
terraform show | grep public_ip
```

Finally, please access to the instance with your private key. If your private key is not `id_rsa`, you need to fix this path specified with `-i` option.
```
ssh -i ~/.ssh/id_rsa -l ec2-user PUBLIC_IP
```

## Terraform Commands
```
terraform init                    # source module copy, backend initialization, child module installation, and plugin installation
terraform console                 # interactive REPL
terraform fmt --recursive         # format indents in ./*/*.tf
terraform get -update             # download and update modules mentioned in the root module
terraform plan [-destroy]         # dry run
terraform apply                   # apply configuration
terraform show                    # check state
terraform destroy [-auto-approve] # destroy the Terraform-managed infrastructure
```

## Detail
- Separating environment directory
  - For separating `terraform.tfstate`, which stores state about infrastructure and configuration.

## Feedback
- [Tweet me](https://twitter.com/_resotto_) with any other feedback.

