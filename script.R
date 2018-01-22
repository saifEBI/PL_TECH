



source("https://bioconductor.org/biocLite.R")
biocLite("ExpressionAtlas")
library("ExpressionAtlas")

sink("output_file", append=TRUE, split=FALSE)

experimentAccessions=c('E-MTAB-513') # , 'E-MTAB-2836', 'E-MTAB-3716', 'E-MTAB-4344', ''E-MTAB-5214'
allExps=getAtlasData(experimentAccessions)

for (acc in experimentAccessions)
{
	exp=allExps[[acc]];
	rna=exp$rnaseq;
	ass=assays(rna);
	parts=rna$organism_part;
	rowindex=1;

	for(gene in rownames(ass$counts))
	{
		colindex=1;
		for(col in colnames(ass$counts))
		{
			value=(ass$counts[rowindex,colindex]);
			tissue=parts[colindex];
			cat(gene,"\t",tissue,"\t",value,"\n");
			colindex=colindex+1;
		}
		rowindex=rowindex+1;
	}
}




