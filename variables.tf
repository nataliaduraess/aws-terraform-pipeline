variable "environment" {
    description = "setup the environment"
}

variable "project_name" {
    description = "Nome do projeto"
}

variable "bucket_names" {
    type = list(string)
}