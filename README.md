# sc-transmogrifier

A containerized tool for converting single-cell data between Seurat objects (R) and AnnData (Python) formats.

## Overview

sc-transmogrifier is a utility designed to facilitate the transformation of single-cell data between the popular R-based Seurat objects and Python-based AnnData objects. This enables researchers to easily switch between different single-cell analysis workflows and tools within the R and Python ecosystems. The conversion code is primarily based on SeuratDisk. The main contribution of this project is to provide a standalone and self-contained service, including necessary patches (e.g., issue #1) for format conversion. This is particularly convenient when working with large datasets or when you want to isolate conversion-related packages from your project environment.

![image](https://user-images.githubusercontent.com/18092300/229930050-2ca37eef-e83c-43e2-a853-39d01c8dfc06.png)

## Features List

- [x] SeuratRDS -> h5seurat -> h5ad
- [ ] h5ad -> h5seurat -> SeuratRDS

## Installation

### Docker

To pull the docker image, use the following command:

```bash
docker pull kuangda/sc-transmogrifier
```

Test the functionality of the image with this command:

```bash
docker run --rm kuangda/sc-transmogrifier bash test.sh
```

### Sigularity

To be added.

## Usage

To run the docker container, use the following command, replacing `<LOCAL INPUT DIR>`, `<LOCAL OUTPUT DIR>`, and `<LOCAL GIT REPO>:` with the appropriate paths:

```bash
docker run --rm\
 -v <LOCAL INPUT DIR>:/app/data\
 -v <LOCAL OUTPUT DIR>:/app/out\
 -v <LOCAL GIT REPO>:/app/sc-transmogrifier\
 kuangda/sc-transmogrifier\
 bash /app/sc-transmogrifier/run-seurat2ann.sh <RDS FILE> <ASSAY NAME> <RAW ONLY>
```

### Example

The following command demonstrates how to run the container with specific input and output directories:

```bash
docker run --rm\
 -v /mnt/nvme-1/2-hubmap/spatial/ref-scrna/data/ft:/app/data\
 -v /mnt/nvme-1/2-hubmap/spatial/ref-scrna/out/ft:/app/out\
 -v /mnt/nvme-1/2-hubmap/sc-transmogrifier:/app/sc-transmogrifier\
 kuangda/sc-transmogrifier\
 bash /app/sc-transmogrifier/run-seurat2ann.sh /app/data/FT_wnn_integrated-0713.RDS RNA TRUE
```

## Docker Environment

### VSCode Devcontainer

The development environment is managed by `.devcontainer` configuration.

### Update Docker Image

To rebuild and push the docker image to DockerHub, use the following command:

```bash
bash .docker/docker-build.sh
```
