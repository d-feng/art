# Load required libraries
library(pheatmap)
library(dplyr)
library(tidyr)
library(scales)

# Example dataset
# Replace this with your actual data
data <- data.frame(
  Feature = rep(c("Gene1", "Gene2", "Gene3", "Gene4"), each = 3),
  SampleID = rep(c("Sample1", "Sample2", "Sample3"), times = 4),
  Group = rep(c("A", "B", "C"), times = 4),
  Value = c(2.3, 1.2, 0.9, 3.4, 2.5, 1.8, 0.8, 0.7, 0.9, 2.1, 1.6, 1.3)
)

# Reshape data into wide format
wide_data <- data %>%
  pivot_wider(names_from = SampleID, values_from = Value) %>%
  column_to_rownames(var = "Feature")

# Calculate z-scores across rows (features)
z_scores <- t(apply(wide_data, 1, function(x) scale(x)))

# Generate heatmap
pheatmap(
  z_scores,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  annotation_col = data.frame(Group = factor(data$Group[1:3])), # Adding group annotations
  color = colorRampPalette(c("blue", "white", "red"))(50),
  main = "Heatmap of Features (Z-scores)",
  fontsize = 12
)