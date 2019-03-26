#/bin/bash

gcloud compute instances create reddit-full\
 --image "reddit-base-1553632708" \
 --machine-type=f1-micro \
 --zone=europe-west1-b \
 --restart-on-failure \
