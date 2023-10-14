## Terrahouse AWS

```tf
module "home_dew" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.dew.public_path
  content_version = var.dew.content_version
}
```

Public Directory Expects:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not subdirectories.