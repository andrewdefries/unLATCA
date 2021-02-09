library(ChemmineR)
#library(heatmaply)

sdfset<-read.SDFset("master.sdf")


blockmatrix <- datablock2ma(datablocklist=datablock(sdfset)) # Converts data block to matrix 
numchar <- splitNumChar(blockmatrix=blockmatrix) # Splits to numeric and character matrix 

#export and do some cleaning in excel via find and replace
write.table(blockmatrix, file="master.csv", sep=",", quote=T)

#re-import and export as markdown hack
table<-read.csv("master.csv")

#subset only essential fields
table<-table[,6:14]
write.table(table, file="master.md", sep="|", quote=F, row.names=F)

system("cat master.md | sed 's/^/\|/' | sed 's/$/\|/' > tmp"
system("mv tmp master.md")


cid(sdfset)<-datablocktag(sdfset,tag="LATID")

#3649 compounds trimmed to 3638 compounds bc 11 invalid
#find which ones later

valid <- validSDF(sdfset); sdfset <- sdfset[valid]

sdfset<-sdfset[-3125]
sdfset<-sdfset[-3115]

apset<-sdf2ap(sdfset)

#apset failures
which(sapply(as(apset, "list"), length)==1)

#CMP3124 CMP3135 
#LAT007E07 LAT007F07 
#   3115    3125 

fpset <- desc2fp(apset)
#jp<-jarvisPatrick(nearestNeighbors(apset,numNbrs=8), k=5, mode="a1a2b")
jp<-jarvisPatrick(nearestNeighbors(fpset,numNbrs=8), k=5, mode="a1a2b")

cl<-jarvisPatrick(nearestNeighbors(fpset,cutoff=0.75, method="Tanimoto"), k=2 ,mode="b")

byCluster(cl) 


#

nnm <- nearestNeighbors(fpset,numNbrs=6)
