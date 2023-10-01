# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our Terraform project's root module structure:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform and Input Variables
### Terraform Cloud Variables

There is two kinds of variables that can be set in Terraform Cloud:
- Environment Variables - to be set in bash terminal e.g. AWS credentials
- Terraform Variables - to be set in tfvars file

We can set Terraform Cloud Variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

`-var-file` flag is used to specify a file to load variable values. This can be useful when we have multiple sets of configurations and want to manage variable definitions in separate files. eg. `terraform apply -var-file="my-variables.tfvars"`

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

An file extension in Terraform Cloud (also `.auto.tfvars`) in working directory will be automatically loaded to populate variables. Useful for segregating different sets of configurations or when working with multiple environments. We can organize varibale definitions without specifying them on command line or individual config files.

### Order of terraform variables

1. **Environment Variables**: 
   - These are the first in the order of precedence. We can set in shell or in a Terraform Cloud workspace.
  
2. **terraform.tfvars File**:
   - If present, this file is loaded next. Variables defined here will override environment variables.
  
3. **terraform.tfvars.json File**:
   - If present, this file is loaded following the `terraform.tfvars` file. Variables defined here will override those in the `terraform.tfvars` file and environment variables.
  
4. **\*.auto.tfvars and \*.auto.tfvars.json Files**:
   - These files are loaded next, in lexical order of their filenames. Variables defined in these files will override those defined in the `terraform.tfvars`, `terraform.tfvars.json` files, and environment variables.
  
5. **-var and -var-file options on the Command Line**:
   - These are the final and highest precedence level. Variables set with these options will override those set in all other sources including those set by a Terraform Cloud workspace.
