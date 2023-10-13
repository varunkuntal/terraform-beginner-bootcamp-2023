terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #   cloud {
  #   organization = "Varuntf"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }

}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "Sustainable Symphony in 2023!"
  description = <<DESCRIPTION
Embark on a melodic journey through the serene and sustainable landscapes of our future. Sustainable Symphony is an orchestration of eco-friendly practices, innovative digital solutions, and harmonic living. Here, we create a melody that soothes the earth and nourishes our souls, composing a future where technology and ecology coalesce in a gentle, sustainable embrace. Dive into our harmonious guide, explore green technologies, and join us in composing a future that is a Sustainable Symphony.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "d2p4khshwukv10.cloudfront.net"
  town = "cooker-cove"
  content_version = 1
}
