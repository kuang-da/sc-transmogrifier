#! /bin/bash
# This is the script to build the docker image.
# It is not intended to be run as part of the pipeline.
docker build -t kuangda/sc-transmogrifier -f .docker/dockerfile .
# docker push kuangda/sc-transmogrifier
