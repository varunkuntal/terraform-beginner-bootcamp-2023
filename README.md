# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project will utilize Semantic Versioning for its tagging.
[Semver.org](https://semver.org)

The general format:

**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatiable API changes
- **MINOR** version when you add functionality in a backward compatiable manner
- **PATCH** version when you make backward compatiable bug fixes


## Terraform CLI Installation

Refer to latest installation instructions via Terraform Docs:

[Install Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


## Bash Script Refactor

A bash script [`install_terraform_cli`](./bin/install_terraform_cli) was created for terraform installation to keep GitPod Task File [`.gitpod.yml`](.gitpod.yml) tidy.


[GitPod Workspace Docs](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Considerations for Linux Distribution

These instructions hold well for Ubuntu (or Debian based distros). 

To check if OS Version is Linux, you should be able to using:

```sh
$ cat /etc/os-release 

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


#### A Hashbang (or Shebang) tells bash script what program will interpret the script:

[HashBang Wikipedia](https://en.wikipedia.org/wiki/Shebang_(Unix))

As best practice and for portability for distributions other than Ubuntu, we should use `#!/usr/bin/env bash`, which searches user's PATH for the bash executables.

While executing bash script we can use `./` notations.

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`



### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working Env Vars

#### env command

We can list out all Enviroment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world`

In the terrminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in thoes workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-senstive env vars.


### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is succesful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM User in order to the user AWS CLI.



## Steps to create IAM user:

1. **Login to AWS Console** and navigate to `IAM`.
2. Go to `Users` > `Add user`.
3. Enter `User name`.
4. Select `Access type` (Programmatic, AWS Management Console, or both).
5. Assign `Permissions` (Attach existing policies, add to group, or copy permissions).
6. (Optional) Set up `Password` if AWS Management Console access is enabled.
7. Review and click `Create user`.


## Terraform Basics Documentation

### Terraform Registry
The Terraform Registry ([registry.terraform.io](https://registry.terraform.io/)) is where Terraform sources providers and modules.
- **Providers:** Interfaces to APIs to create resources.
- **Modules:** Make Terraform code modular, portable, and sharable.

Example: [Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console
Type `terraform` to list all Terraform commands.

#### `terraform init`
Run at the start of a project to download the necessary provider binaries.

#### `terraform plan`
Generates a changeset of what will be altered. It can be directly applied without outputting.

#### `terraform apply`
Executes the plan, prompting for approval unless `--auto-approve` is added.

### Lock & State Files
- `.terraform.lock.hcl`: Locks versioning for providers and modules; commit to VCS.
- `.terraform.tfstate`: Contains current infrastructure state; do not commit due to sensitivity. This file **should not be committed** to your VCS.
- `.terraform.tfstate.backup`: Holds previous state.

### Terraform Directory
The `.terraform` directory houses the binaries of Terraform providers.


## Issue with Terraform Cloud Login
Sometimes when attempting to run `terraform login`, it launches a wiswig view in lynx browser. However it does not work as expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token in Terraform Cloud:

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create a file manually here:

```
nano /home/gitpod/.terraform.d/credentials.tfrc.json
```

Use the following code:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "THE-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```


Automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)