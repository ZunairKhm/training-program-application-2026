# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------

# You may use base R or tidyverse for this exercise

# ex. library(tidyverse)
library(tidyverse)

# Load data here ----------------------
# Load each file with a meaningful variable name.
meta <- read.csv("data/GSE60450_filtered_metadata.csv")
gene_exp <- read.csv("data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")


# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.



## Expression data
dim(gene_exp)

## Metadata
dim(meta)

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?
gene_exp_long <- gene_exp |>
  pivot_longer(
    starts_with("GSM"),
    names_to = "sample",
    values_to = "CPM"
  )|>
  left_join(meta, by = join_by("sample"=="X"))


# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2
gene_exp_long|>
  ggplot(aes(y=CPM, x=immunophenotype))+
  ggbeeswarm::geom_quasirandom(size=0.1, alpha=0.4)+
  geom_boxplot(outliers = F, alpha=0.7, staplewidth  = 1)+
  scale_y_continuous(trans="pseudo_log", breaks=c(0, 10^(0:5), 200000))+
  theme_bw()+
  labs(title= "Gene expression by cell type", y= "Counts per million", x="Cell type")



## Save the plot
### Show code for saving the plot with ggsave() or a similar function
ggsave("exp_cell_type.png", get_last_plot())
