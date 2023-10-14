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

module "home_cadillacs_dinos_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.cadillacs_dinos.public_path
  content_version = var.cadillacs_dinos.content_version
}

resource "terratowns_home" "home" {
  name = "Revitalizing Cadillacs and Dinosaurs in 2023!"
  description = <<DESCRIPTION
Welcome to a page dedicated to the timeless classic, “Cadillacs and Dinosaurs”! 
Originally released by Capcom in 1993, this side-scrolling beat 'em up game left an indelible mark on the hearts of arcade gamers worldwide. 
EARLY 26TH CENTURY... 100 YEARS HAVE PAST SINCE MEN AND DINOSAURS BECAME TO LIVE TOGETHER. 
SUDDENLY THE POACHERS APPEARED FROM SOMEWHERE AND BEGAN TO SLAUGHTER THE DINOSAURS.
THE DINOSAURS GO ON A RAMPAGE AND THE WHOLE WORLD IS NOW IN CONFUSION.
TO REVEAL THEIR EVIL PLOT, 4 BRAVES GET TOGETHER! THEIR ADVENTURE HAS JUST BEGUN!!
In order to get things sorted again, mechanic and shaman Jack Tenrec, diplomat and explorer by profession Hannah Dundee, 
friend and engineer Mustapha Cairo, and mysterious Mess O'Bradovich have decided to team up against the evil deeds 
of the Black Marketeers. The protagonists reach "the City in the Sea" where they suspect 
the whole hunting network being operating from..
DESCRIPTION
  domain_name = module.home_cadillacs_dinos_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.cadillacs_dinos.content_version
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
  town = "video-valley"
  content_version = var.dew.content_version
}
