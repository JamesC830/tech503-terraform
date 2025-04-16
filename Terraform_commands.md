# Terraform commands

When using terraform, first make a new sub directory for the task you want to do. (e.g. make an ec2 instance)

## Important: Add a .gitignore file containing the following:

```
#Ignore the gitignore file
.gitignore

# Should never be on github or commit history
terraform.tfstate
terraform.tfstate.backup

# Optional ignore to avoid bloating the repo
.terraform
```

**The .tfstate files contain sensitive information such as access keys and so should never be on github or your commit history**

Make a ```main.tf``` file, this is where we will put our code.

## Workflow

  After we have written the ```main.tf``` file containing the instructions of what we want to make:
- ```terraform init```: Much like git init is sets the groundwork. It will also add a number of files to the repo required to make things work
- ```terraform fmt```: Like ansible syntax check. Makes sure the main.tf file has no syntax errors
- ```terraform plan```: Gives a rundown of what the main file will create. (Tells you what terraform is going to do, without actually doing it)
- ```terraform apply```: Applies the plan. (e.g. makes the instances)
- ```terraform destroy```: Shuts down or deletes everything that terraform has a record or creating