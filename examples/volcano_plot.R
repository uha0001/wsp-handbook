# Load the EnhancedVolcano package.
library(EnhancedVolcano)

# Create a volcano plot from the differential
# expression results.
#
# Each point represents a gene.
# Genes with large fold changes and low p-values
# appear farther from the center and higher on the plot.

EnhancedVolcano(results)
