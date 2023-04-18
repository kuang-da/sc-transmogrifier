#! /bin/bash

# This is a testing script to inspect the functionality of the environment.
# It is not intended to be run as part of the pipeline.
mkdir -p data/test
Rscript seurat2ann-test.R
