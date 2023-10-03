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


## Dealing With Configuration Drift

## What happens if we lose our state file?

After losing our statefile, we may have to tear down all your cloud infrastructure manually.

We can use terraform port but it won't for all cloud resources. We need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan it with attempt to put our infrastraucture back into the expected state fixing Configuration Drift


## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```


## Terraform Modules

### Terraform Module Structure

Recommend to place modules in a `modules` directory when locally developing modules, name can be anything.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


## Considerations when using ChatGPT to write Terraform

Terraform documentation keeps changing frequently, LLMs like ChatGPT may not have the latest information.

In these cases, they are likely to produce examples that may be deprecated.

## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Working with Files in Terraform

### Fileexists function

Built-in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

A special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}