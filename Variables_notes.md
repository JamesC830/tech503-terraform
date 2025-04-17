#  Variables

### Why use variables?

- ***Readablility***: Adds a layer of abstraction to the code, making it easier to follow
- ***Security***: We can hide sensitive information in the variables files which will be added to the .gitignore
- ***Flexibility***: We can have multiple .tfvars files for different environments. So if our production and pre production environments use different values for the same variables, we simply reference which set of variables we want to use when doing a ```terraform apply```

### In main.tf:

Example syntax of variables:

```ami = var.base_ubuntu_22_ami_id```

This says that the ami id will take the value base_ubuntu_22_ami_id which we have specified in our ```variables.tf``` file

### In variables.tf

Example of syntax of variables:

```
variable "base_ubuntu_22_ami_id" {
    description = "AMI ID for base ubuntu 22 image"
    type = string
}
```

This says that the variable "base_ubuntu_22_ami_id" will be a string, which we can give a value in our ```.tfvars``` files

### In prod.tfvars

Example syntax:

```base_ubuntu_22_ami_id = "ami-0f0c3baa60262d5b9"```

We simply state the value as the variable declaration was done in the ```variables.tf``` file

## Important: Add variables.tf and all .tfvars files to the .gitignore

### Terraform commands

To use a specific set of variables in terraform commands we use the syntax:

```terraform plan -var-file="prod.tfvars"```

This would use the set of variables specified in prod.tfvars

We need to add the ```-var-file="prod.tfvars``` to the end of all commands


