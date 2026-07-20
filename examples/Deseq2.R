# Example: Differential gene expression analysis using DESeq2.
#
# Required input files:
# - counts.csv   : Gene count matrix (genes × samples)
# - metadata.csv : Sample information including the "condition" column
#
# Output:
# - DE_results.csv : Differential expression results

# Load the DESeq2 package.
# Make sure DESeq2 is installed before running this script.
library(DESeq2)

# Read the count matrix.
# Rows should be genes and columns should be samples.
counts <- read.csv("counts.csv", row.names = 1)

# Read the sample metadata.
# Each row should correspond to one sample in the count matrix.
metadata <- read.csv("metadata.csv", row.names = 1)

# Create a DESeq2 dataset.
# countData = gene expression counts
# colData = sample information
# design = experimental variable to test
dds <- DESeqDataSetFromMatrix(
    countData = counts,
    colData = metadata,
    design = ~ condition
)

# Perform differential expression analysis.
dds <- DESeq(dds)

# Extract the statistical results.
results <- results(dds)

# Save the results to a CSV file.
write.csv(results, "DE_results.csv")
