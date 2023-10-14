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
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Sustainable Symphony in 2023!"
  description = <<DESCRIPTION
Embark on a melodic journey through the serene and sustainable landscapes of our future. Sustainable Symphony is an orchestration of eco-friendly practices, innovative digital solutions, and harmonic living. Here, we create a melody that soothes the earth and nourishes our souls, composing a future where technology and ecology coalesce in a gentle, sustainable embrace. Dive into our harmonious guide, explore green technologies, and join us in composing a future that is a Sustainable Symphony.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  # domain_name = "d2p4khshwukv1.cloudfront.net"
  town = "missingo"
  content_version = 1
}
