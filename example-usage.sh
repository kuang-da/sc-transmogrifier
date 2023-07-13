#!/bin/bash
bash .docker/docker-build.sh
docker run --rm\
 -v /mnt/nvme-1/2-hubmap/spatial/ref-scrna/data/ft:/app/data\
 -v /mnt/nvme-1/2-hubmap/spatial/ref-scrna/out/ft:/app/out\
 -v /mnt/nvme-1/2-hubmap/sc-transmogrifier:/app/sc-transmogrifier\
 kuangda/sc-transmogrifier\
 bash /app/sc-transmogrifier/run-seurat2ann.sh /app/data/FT_wnn_integrated-0713.RDS RNA TRUE
