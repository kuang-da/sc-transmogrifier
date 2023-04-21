library(Seurat)
library(SeuratDisk)
library(Signac)

args <- commandArgs(trailingOnly = TRUE)
seurat_file_name <- args[1]

# Define output file names
output_basename <- gsub(".RDS", "", basename(seurat_file_name))
output_dir <- "/app/out"
h5seurat_file_name <- file.path(output_dir, paste0(output_basename, ".h5Seurat"))
h5ad_file_name <- file.path(output_dir, paste0(output_basename, ".h5ad"))

cat("Input Seurat file:", seurat_file_name, "\n")
cat("Output directory:", output_dir, "\n")
print("----------------------------------------")
# Load the Seurat object
cat("Loading Seurat object...\n")
seurat_obj <- readRDS(seurat_file_name)

# Preprocess the Seurat object
# Convert factors to characters
# Related issue: https://github.com/kuang-da/sc-transmogrifier/issues/1
i <- sapply(seurat_obj@meta.data, is.factor)
seurat_obj@meta.data[i] <- lapply(seurat_obj@meta.data[i], as.character)

# Print some info
cell_names <- colnames(seurat_obj@assays$RNA@counts)
gene_names <- rownames(seurat_obj@assays$RNA@counts)
cat("Seurat object info:\n")
cat("Sample cell names:", cell_names[1:5], "\n")
cat("Sample gene names:", gene_names[1:5], "\n")
print(seurat_obj)
print("----------------------------------------")

# Convert to AnnData
cat("--------- Converting Seurat object to AnnData...\n")
SaveH5Seurat(seurat_obj, filename = h5seurat_file_name)
Convert(h5seurat_file_name, dest = "h5ad")
cat("Done converting to AnnData.\n")
cat("Output AnnData file:", h5ad_file_name, "\n")
