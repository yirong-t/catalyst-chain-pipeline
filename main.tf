terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.36.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "data_lake_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type  = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "raw_dataset" {
  dataset_id  = var.raw_dataset_name
  location    = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "prod_dataset" {
  dataset_id  = var.prod_dataset_name
  location    = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "dev_dataset" {
  dataset_id  = var.dev_dataset_name
  location    = var.location
  delete_contents_on_destroy = true
}