source("https://bioconductor.org/biocLite.R")
biocLite("ExpressionAtlas")
experimentAccessions=c('E-MTAB-5214', 'E-MTAB-513', 'E-MTAB-2836', 'E-MTAB-3716', 'E-MTAB-4344')
getAtlasData(experimentAccessions)

