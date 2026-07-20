# Load the pheatmap package.
library(pheatmap)

# Create a heatmap from variance-stabilized count data.
#
# assay(vsd) extracts the expression matrix from the
# variance-stabilized DESeq2 object.
#
# Each row represents a gene and each column represents a sample.

pheatmap(assay(vsd))
