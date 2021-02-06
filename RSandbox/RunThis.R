library(ChemmineR)
#library(heatmaply)

sdfset<-read.SDFset("master.sdf")


blockmatrix <- datablock2ma(datablocklist=datablock(sdfset)) # Converts data block to matrix 
numchar <- splitNumChar(blockmatrix=blockmatrix) # Splits to numeric and character matrix 
write.table(blockmatrix, file="master.csv", sep=",", quote=T)

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
