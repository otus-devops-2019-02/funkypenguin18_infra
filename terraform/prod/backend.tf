terraform {
  backend "gcs" {
    bucket = "penguin-bucket2"
    prefix = "terraform/state"
  }
}

