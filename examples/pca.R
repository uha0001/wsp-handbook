# Perform a variance stabilizing transformation (VST).
#
# This transforms count data so that the variance is more
# consistent across genes, making it suitable for
# visualization and clustering.

vsd <- vst(dds)

# Create a Principal Component Analysis (PCA) plot.
#
# Samples are colored according to the "condition" column
# in the metadata. Samples that cluster together have
# similar gene expression profiles.

plotPCA(vsd, intgroup = "condition")
