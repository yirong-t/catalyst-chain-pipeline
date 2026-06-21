variable "project" {
    description = "Project"
    default = "catalyst-chain-project"
}

variable "region" {
    description = "Region"
    default = "us-central1"
}

variable "location" {
    description = "Project location"
    default = "US"
}


variable "raw_dataset_name" {
    description = "My BigQuery dataset name"
    default = "raw_supply_chain"
}

variable "prod_dataset_name" {
    description = "My BigQuery dataset name"
    default = "dbt_analytics"
}

variable "dev_dataset_name" {
    description = "My BigQuery dataset name"
    default = "dbt_development"
}

variable "gcs_bucket_name" {
    description = "My Storage bucket name"
    default = "catalyst-chain-data-lake"
}

variable "gcs_storage_class" {
    description = "Bucket storage class"
    default = "STANDARD"
}

