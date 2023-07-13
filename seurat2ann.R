library(Seurat)
library(SeuratDisk)
library(Signac)

args <- commandArgs(trailingOnly = TRUE)
seurat_file_name <- args[1]
seurat_assay <- args[2]
raw_only <- as.logical(args[3])

# Define output file names
output_basename <- gsub(".RDS", "", basename(seurat_file_name))
output_dir <- "/app/out"
h5seurat_file_name <- file.path(output_dir, paste0(output_basename, ".h5Seurat"))
h5ad_file_name <- file.path(output_dir, paste0(output_basename, ".h5ad"))

cat("Input Seurat file:", seurat_file_name, "\n")
cat("Output directory:", output_dir, "\n")
cat("----------------------------------------\n")
# Load the Seurat object
cat("Loading Seurat object...\n")
seurat_obj <- readRDS(seurat_file_name)

# Preprocess the Seurat object
# Convert factors to characters
# Related issue: https://github.com/kuang-da/sc-transmogrifier/issues/1
i <- sapply(seurat_obj@meta.data, is.factor)
seurat_obj@meta.data[i] <- lapply(seurat_obj@meta.data[i], as.character)

#' \subsection{Assay data}{
#'  \itemize{
#'   \item \code{X} will be filled with \code{scale.data} if \code{scale.data}
#'   is present; otherwise, it will be filled with \code{data}
#'   \item \code{var} will be filled with \code{meta.features} \strong{only} for
#'   the features present in \code{X}; for example, if \code{X} is filled with
#'   \code{scale.data}, then \code{var} will contain only features that have
#'   been scaled
#'   \item \code{raw.X} will be filled with \code{data} if \code{X} is filled
#'   with \code{scale.data}; otherwise, it will be filled with \code{counts}. If
#'   \code{counts} is not present, then \code{raw} will not be filled
#'   \item \code{raw.var} will be filled with \code{meta.features} with the
#'   features present in \code{raw.X}; if \code{raw.X} is not filled, then
#'   \code{raw.var} will not be filled
#'  }
#' }

if (raw_only) {
    cat("Keeping only raw data.\n")
    # seurat_obj@assays$RNA@data <- seurat_obj@assays$RNA@counts
    new_data <- GetAssayData(
        object = seurat_obj, 
        assay = seurat_assay, slot = "counts"
        )
    
    seurat_obj <- SetAssayData(
        object = seurat_obj, 
        assay = seurat_assay, slot = "data", 
        new.data = new_data
        )
}

# Print some info
cell_names <- colnames(seurat_obj@assays$RNA@counts)
gene_names <- rownames(seurat_obj@assays$RNA@counts)
cat("Seurat object info:\n")
cat("Sample cell names:", cell_names[1:5], "\n")
cat("Sample gene names:", gene_names[1:5], "\n")
print(seurat_obj)
cat("----------------------------------------\n")

# Convert to AnnData
cat("--------- Converting Seurat object to AnnData...\n")
SaveH5Seurat(seurat_obj, filename = h5seurat_file_name)
cat("Done converting to h5Seurat.\n")
cat("--------- Converting Assay", seurat_assay, "to AnnData...\n")
Convert(h5seurat_file_name, assay = seurat_assay, dest = "h5ad")
cat("Done converting to AnnData.\n")
cat("Output AnnData file:", h5ad_file_name, "\n")
