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

```
docker pull kuangda/sc-transmogrifier
```

Test the functionality of the image with this command:
```
docker run --rm kuangda/sc-transmogrifier bash test.sh
```

### Sigularity
To be added.

## Usage
To run the docker container, use the following command, replacing `<LOCAL INPUT DIR>` and `<LOCAL OUTPUT DIR>` with the appropriate paths:

```
docker run -it --rm -v <LOCAL INPUT DIR>:/app/data -v <LOCAL OUTPUT DIR>:/app/data kuangda/sc-transmogrifier bash run-seurat2ann.sh <RDS FILE>
```

### Example
The following command demonstrates how to run the container with specific input and output directories:

```
docker run --rm -v\
 /home/derek/research/Kim-Lab/2-hubmap/spatial/ref-scrna/data/ft:/app/data\
 -v /home/derek/research/Kim-Lab/2-hubmap/spatial/ref-scrna/out/ft:/app/out\
 kuangda/sc-transmogrifier\
 bash run-seurat2ann.sh /app/data/seurat_archr_combined_FT.RDS
```

## Docker Environment

### VSCode Devcontainer

The development environment is managed by `.devcontainer` configuration.

###  Update Docker Image

To rebuild and push the docker image to DockerHub, use the following command:

```
bash .docker/docker-build.sh
```
