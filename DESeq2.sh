library(DESeq2)

counts <- read.csv("counts.csv",row.names=1)

metadata <- read.csv("metadata.csv",row.names=1)

dds <- DESeqDataSetFromMatrix(
    countData=counts,
    colData=metadata,
    design=~condition
)

dds <- DESeq(dds)

results <- results(dds)

write.csv(results,"DE_results.csv")
