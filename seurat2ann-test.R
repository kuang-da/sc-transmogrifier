library(Seurat)
library(SeuratDisk)

test_rds_name <- "data/test/pbmc3k_final.RDS"
test_hseurat_file_name <- "data/test/pbmc3k.h5Seurat"
if (!file.exists(test_rds_name)) {
    print("Test file does not exist.")
    print("Downloading pbmc3k_final.RDS...")
    library(SeuratData)
    InstallData("pbmc3k")
    print("Done downloading pbmc3k_final.RDS.")
    data("pbmc3k.final")
    pbmc3k_final <- UpdateSeuratObject(object = pbmc3k.final)
    saveRDS(pbmc3k_final, file = test_rds_name)
    print("Done saving pbmc3k_final.RDS.")
}else {
    print("Test file exists.")
    print("Reading pbmc3k_final.RDS...")
    pbmc3k_final <- readRDS(test_rds_name)
    print("Done reading pbmc3k_final.RDS.")
}

print("Saving pbmc3k_final.h5Seurat...")
SaveH5Seurat(pbmc3k_final, filename = test_hseurat_file_name)
print("Done saving pbmc3k_final.h5Seurat.")

print("Converting pbmc3k.h5Seurat to pbmc3k.h5ad...")
Convert(test_hseurat_file_name, dest = "h5ad")
print("Done converting pbmc3k.h5Seurat to pbmc3k.h5ad.")
print("Success!")
