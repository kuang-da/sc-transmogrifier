#!/bin/bash

docker run --rm -v\
 /home/derek/research/Kim-Lab/2-hubmap/sc-transmogrifier/data/ft:/app/data\
 -v /home/derek/research/Kim-Lab/2-hubmap/sc-transmogrifier/out/ft:/app/out\
 kuangda/sc-transmogrifier\
 bash run.sh /app/data/seurat_archr_combined_FT.RDS
