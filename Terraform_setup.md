# Terraform setup

## Installing terraform

[Terraform install guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- Download terraform
- Unzip
- Move it into it's own folder (mine is in "C:\terraform_1.11.4_windows_386")

## Adding environment variables

### Terraform environment variable

This needs to be done so that terraform can be accessed from any directory in git bash

- Go to advanced system settings

<img src="./Images/advanced_settings.png" alt="alt text" width="200"/>

----
- Go to environment variables
- In user variables:
  - Edit the PATH variable
  - Add a new value with the path to terraform (C:\terraform_1.11.4_windows_386)

<img src="./Images/evs.png" alt="alt text" width="300"/>

Where it says "c:\terraform", replace this with the path to your terraform folder

- To verify it worked:
  - Open a powershell or gitbash window
  - type ```terraform --version```

Expected output
```
Terraform v1.11.4
on windows_386
```

### AWS environment variables

Need to create system vaiables called AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

- Press Windows+R to open the windows run prompt
- Type sysdm.cpl and click OK
  

<img src="https://phoenixnap.com/kb/wp-content/uploads/2021/04/setting-environment-variables-in-windows-06.png" alt="alt text" width="300"/>

---
- Go to advanced: Environment variables
- Make a 2 new system varaibles which are your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

<img src="https://phoenixnap.com/kb/wp-content/uploads/2021/04/setting-environment-variables-in-windows-09.png" alt="alt text" width="400"/>