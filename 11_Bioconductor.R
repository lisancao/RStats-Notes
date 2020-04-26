############################################################
## Visualization of gene expression data 
############################################################

setwd("~/Documents/coursework/intro_to_datascience/assignments/assignment7")

# load libraries 
library(GEOquery)
library(Matrix)
library(S4Vectors)
library(dplyr)

# access series data 
GSE = "GSE21935"
gse_import = getGEO(GSE, GSEMatrix = TRUE)
show(gse_import)

# access raw data 
geoFILE = getGEOSuppFiles(GSE)
geoFILE

# Extract S4 Class Tables 
masterdata = gse_import$GSE21935_series_matrix.txt.gz
pheno_m = masterdata@phenoData
assay_m = masterdata@assayData
gene_m = masterdata@featureData

# use unclass() to view data (OPTIONAL)
pheno_uncl = unclass(pheno_m)
assay_uncl = unclass(assay_m)
# Extract phenoData and assayData as dataframes 
pheno_data = pData(phenoData(masterdata))
assay_data = assayDataElement(masterdata@assayData, 'exprs') %>% 
  as.data.frame() %>% 
  cbind(gene = rownames(.), .)
gene_data = pData(featureData(masterdata))

# create data frame with 1 row for first 10 genes and entries given by the gene expression 
exprsframe = assay_data[1:10, ]

# In R, create a dataframe x with column names given by the gene names, and with one row for each sample and entries given by the gene expression 
x = data.frame(t(exprsframe[-1]))
colnames(x) = exprsframe[,1]

# create a vector y with coordinates giving the schizophrenia indicator, in the same order as the sameples are listed in the dataframe x that is Yi is 1 if the nth row of x correpondes to a schozp subject and 0 of the nth row of x corresponds to a nonschizo subject 

# subset a dataframe for easier viewing (not required)
prep_vec = data.frame(title = pheno_data$title, accession = pheno_data$geo_accession, disease_status = pheno_data$`disease state:ch1`)

gene_vec = data.frame(gene_ID = gene_data$ID, Gene = gene_data$`Gene Symbol`)

schiz_vec = ifelse(prep_vec$disease_status == "control", 0, 1) %>% 
  as.vector(.)

schiz_col = ifelse(prep_vec$disease_status == "control", 0, 1)


#sub 0 for ctrl sub 1 for schiz
# exprsframe %in% phenodata
#create vector of lists ph

xlist = rownames(x) 
genelist = colnames(x)



schizxlist = subset(prep_vec, xlist %in% prep_vec$accession) %>% 
  na.exclude()

##################################### DATA PREP FOR SHINY APP 

## data prep 
x_kde = x
# use gene symbols instead of location indicators
geneset = subset(gene_vec, gene_vec$gene_ID == colnames(x_kde))

colnames(x_kde) = geneset$Gene

# bind disease status indicator to data 
x_kde = cbind(x_kde, disease_status = schiz_col) 

# control means
#x_kde = colMeans(subset(x_kde,x_kde$disease_status == 0)) %>% 
  rbind(x_kde, control_mean = .)

# Schiz means
#x_kde = colMeans(subset(x_kde,x_kde$disease_status == 1)) %>% 
  rbind(x_kde, schiz_mean = .)

#save as RDS for shiny 
saveRDS(x_kde, file = "x_kde.rds")

# create info output 

info_vec = data.frame(ID = gene_data$ID, Gene = gene_data$`Gene Symbol`, Accession = gene_data$GB_ACC, Title = gene_data$`Gene Title`, Description = gene_data$`Target Description`) 

info_vec = subset(info_vec, geneset$gene_ID == info_vec$ID)

#save as RDS for shiny 
saveRDS(info_vec, file = "geneinfo.rds")
