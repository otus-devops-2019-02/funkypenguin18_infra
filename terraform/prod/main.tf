terraform {
  # terraform version
  #required_version = "0.11.7"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source = "../modules/app"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone = "${var.zone}"
  app_disk_image = "${var.app_disk_image}"
  db_reddit_ip     = "${module.db.db_local_ip}"
}

module "db" {
  source = "../modules/db"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone = "${var.zone}"
  db_disk_image = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["91.108.29.131/32"]
}

