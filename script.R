E-MTAB-5214

for (acc in experimentAccessions)
{
	w=acc;
	exp = allExps[[w ]];
	sumexp <- exp$rnaseq;
	x=head( assays( sumexp )$counts );
	print(colnames(x));
	index=index+1
}


source("https://bioconductor.org/biocLite.R")
biocLite("ExpressionAtlas")
library("ExpressionAtlas")

experimentAccessions=c('E-MTAB-513', 'E-MTAB-2836', 'E-MTAB-3716', 'E-MTAB-4344')
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





samplePartList=list()

for (acc in experimentAccessions)
{
	exp=allExps[[acc]];
	rna=exp$rnaseq;ass=assays(rna);
	counts=ass$counts;parts=rna$organism_part;
	samples=colnames(counts);
	mylist=c();
	i=1;

	for (temp in samples)
	{
		mylist[[ samples[i] ]] <- parts[i];
		i=i+1;
	}
	samplePartList=c(samplePartList,mylist)}
}


for (acc in experimentAccessions)
{
	exp=allExps[[acc]];
	rna=exp$rnaseq;
	ass=assays(rna);
	counts=ass$counts;
	parts=rna$organism_part;
	rowindex=1;

	for(row in rownames(counts))
	{
		colindex=1;
		for(c in colnames(counts))
		{
			value=(counts[rowindex,colindex]);
			paste(value," is the value of gene ",row," in sample ",c," which maps to ",samplePartList$c)
		colindex=colindex+1;
		}
		rowindex=rowindex+1;
	}
}

exp=allExps[[acc]];
rna=exp$rnaseq;
ass=assays(rna);
counts=ass$counts;
parts=rna$organism_part;
rowindex=1;


r=1;for(row in rownames(counts)){c=1;for(col in colnames(counts)){print(paste(row,samplePartList[col],r,c,counts[r,c]));c=c+1;};r=r+1;}



