#!/bin/bash
gcloud config set account usareru@gmail.com
gcloud config set project boreal-atom-412606
gcloud config list
# If 403 Forbidden Error occurs, run the following command
# gcloud auth application-default login