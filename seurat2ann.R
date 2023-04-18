library(Seurat)
library(SeuratDisk)
library(Signac)

# Load the Seurat object
seurat_file_name <- "data/ft/seurat_archr_combined_FT.RDS"
h5seurat_file_name <- "data/ft/seurat_archr_combined_FT.h5Seurat"
h5ad_file_name <- "data/ft/archr_combined_FT.h5ad"
seurat_obj <- readRDS(seurat_file_name)

# Print some info
cell_names <- colnames(seurat_obj@assays$RNA@counts)
gene_names <- rownames(seurat_obj@assays$RNA@counts)
print("Seurat object info:")
print(cell_names[1:5])
print(gene_names[1:5])
print(seurat_obj)

# Convert to AnnData
# Reference
# https://mojaveazure.github.io/seurat-disk/articles/convert-anndata.html
SaveH5Seurat(seurat_obj, filename = h5seurat_file_name)
Convert(h5seurat_file_name, dest = "h5ad")
print("Done converting to AnnData.")
print(h5ad_file_name)
