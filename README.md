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