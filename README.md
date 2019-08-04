# Commands
terraform
- init                    # source module copy, backend initialization, child module installation, and plugin installation
- console                 # interactive REPL
- fmt --recursive         # format indents in ./\*/\*.tf file
- get -update             # download and update modules mentioned in the root module
- plan [-destroy]         # dry run
- apply
- show                    # check state
- destroy [-auto-approve]

# Separating environment directory
- For separating .tfstate file, which stores state about infrastructure and configuration.

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
