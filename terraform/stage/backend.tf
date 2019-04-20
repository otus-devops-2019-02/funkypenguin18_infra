terraform {
  backend "gcs" {
    bucket = "penguin-bucket1"
    prefix = "terraform/state"
  }
}

