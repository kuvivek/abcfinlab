variable "prefix" {
  default = "sppetclin"
}

variable "project" {
  default = "spring-pet-clinic"
}

variable "contact" {
  default = "email@petclinic.link"
}

variable "db_username" {
  description = "Username for the RDS Postgres instance"
  default     = "petclinic"
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
  default     = "petclinic"
}

variable "bastion_key_name" {
  default = "petclinic-bastion"
}

variable "dns_zone_name" {
  description = "Domain name"
  default     = "petclinic.link"
}

variable "subdomain" {
  description = "Subdomain per environment"
  type        = map(string)
  default = {
    production = "api"
    dev        = "api.dev"
  }
}
