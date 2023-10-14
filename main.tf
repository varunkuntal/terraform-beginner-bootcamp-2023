terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
   organization = "Varuntf"
   workspaces {
     name = "terra-house-1"
   }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "home_symphony_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.symphony.public_path
  content_version = var.symphony.content_version
}

resource "terratowns_home" "home" {
  name = "Sustainable Symphony in 2023!"
  description = <<DESCRIPTION
Embark on a melodic journey through the serene and sustainable landscapes of our future. Sustainable Symphony is an orchestration of eco-friendly practices, innovative digital solutions, and harmonic living. Here, we create a melody that soothes the earth and nourishes our souls, composing a future where technology and ecology coalesce in a gentle, sustainable embrace. Dive into our harmonious guide, explore green technologies, and join us in composing a future that is a Sustainable Symphony.
DESCRIPTION
  domain_name = module.home_symphony_hosting.domain_name
  town = "missingo"
  content_version = var.symphony.content_version
}

module "home_dew_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.dew.public_path
  content_version = var.dew.content_version
}

resource "terratowns_home" "home_dew" {
  name = "Dancing with Digital Dew Drops"
  description = <<DESCRIPTION
Welcome to a realm where technology and nature elegantly entwine, presenting the mesmerizing spectacle of Digital Dew Drops. Our platform is a gentle cascade of technological innovation and natural inspiration, where the digital world mirrors the tranquility and refreshing resilience of morning dewdrops. This guide gently navigates through the delicate balance of embracing digital advancement while honoring and preserving the exquisite simplicity of nature, creating a tranquil digital space that is as refreshing and renewing as dew drops at dawn.
DESCRIPTION
  domain_name = module.home_dew_hosting.domain_name
  town = "missingo"
  content_version = var.dew.content_version
}
