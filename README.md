# Commands
```
terraform init                    # source module copy, backend initialization, child module installation, and plugin installation
terraform console                 # interactive REPL
terraform fmt --recursive         # format indents in ./*/*.tf
terraform get -update             # download and update modules mentioned in the root module
terraform plan [-destroy]         # dry run
terraform apply
terraform show                    # check state
terraform destroy [-auto-approve]
```

# Separating environment directory
- For separating .tfstate, which stores state about infrastructure and configuration.

# How to build each environment
Moving to `env/prod` or `env/dev`, and running following commands:
```
terraform init
terraform get -update
terraform plan
terraform apply
```

Then, access to each instance:
```
ssh -i ~/.ssh/id_rsa -l ec2-user INSTANCE_PUBLIC_IP
```
