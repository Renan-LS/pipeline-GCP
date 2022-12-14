//ESPECIFICA O TIPO DAS VARIÁVEIS UTILIZADAS NO TERRAFORM.TVARS

variable "project_id" {
  type        = string
  description = "The Google Cloud Project Id"
}

variable "region" {
  type    = string
  default = "Google Cloud location of resources"
}