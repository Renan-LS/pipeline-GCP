resources "google_storage_bucket" "gcs_bucket"{
    name = "testebucket111"
    location = var.region
}