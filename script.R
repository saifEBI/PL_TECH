source("https://bioconductor.org/biocLite.R")
biocLite("ExpressionAtlas")
experimentAccessions=c('E-MTAB-5214', 'E-MTAB-513', 'E-MTAB-2836', 'E-MTAB-3716', 'E-MTAB-4344')
allExps=getAtlasData(experimentAccessions)

testGenes=c()
testParts=c()

for (acc in experimentAccessions)
{
	testGenes=c(testGenes,(rownames(assays(allExps[[acc]]$rnaseq)$counts)))
}

uniGenes=unique(testGenes)
rm(testGenes)

testParts=c()
for (acc in experimentAccessions)
{
	testParts=c(testParts,(allExps[[acc]]$rnaseq$organism_part))
}

uniqueParts=unique(testParts)
rm(testParts)



for (acc in experimentAccessions)
{
	w=acc;
	exp = allExps[[w ]];
	sumexp <- exp$rnaseq;
	x=head( assays( sumexp )$counts );
	print(colnames(x));
	index=index+1}

