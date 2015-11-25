args<-commandArgs(TRUE)
# Input variables
userName<-c(args[1])
shape<-c(args[2])
ID<-c(args[3])
Dataset<-c(args[4])
Variable<-c(args[5])
POR1<-c(args[6])
POR2<-c(args[7])

print(userName)
print (shape)
print(ID)
print(Dataset)
print(Variable)
print (POR1)
print (POR2)

# read dataset out of dataset file
dataSets<-read.table("climate_data",colClasses="character")
inClimate<-dataSets[as.integer(Dataset),]
print(inClimate)

# read var out of dataset file
vars<-read.table("dataset_variables",colClasses="character")
inVars<-vars[as.integer(Variable),]
print(inVars)

# create username directory to hold results
ifelse(!dir.exists(file.path(".", userName)), dir.create(file.path(".", userName)), FALSE)

# call libraries and dependencies
library(geoknife,lib.loc=paste("/home/",userName,"/R/x86_64-redhat-linux-gnu-library/3.2",sep=""))
library(RCurl)

# assigns shapefile for GDP summary, this needs to be uploaded to the GDP
#GCPstencil<-webgeom(geom=paste('upload:',shape,sep=""),attribute=ID)
stencil<-webgeom(geom='upload:R06_hru_z',attribute='hru_id')

# define the fabric (climate dataset, variable, and POR)
fabric <- webdata(list(
times = as.POSIXct(c(paste(POR1,'-01-01',sep=""),paste(POR2,'-12-31',sep=""))),
        url = inClimate,
        variables = inVars))

print (fabric)

# submits job to the GDP, generates email to user
job2 <- geoknife(stencil, fabric, wait=TRUE)


# use existing convienence functions to check on the job:
check(job2)

# parses GDP data to dataframe, this is time-consuming
#data<-result(job2)

# downloads GDP file directly to username, folder, this is much more efficient
download.file(paste(job2@id,"OUTPUT",sep=""),destfile=paste(userName,"/",inVars,"_",shape,".csv",sep=""),method="curl")


#**********old code/non-functional*****************************
#***********DO NOT USE***************************
#hru<-readOGR("D:/abock/Water_Balance/Step1_CLIMATE_DATA/Tiles/R06/R06","nhru")
#hru2<-readShapePoly("D:/abock/Water_Balance/Step1_CLIMATE_DATA/Tiles/R06/R06/nhru")
#stencil <- simplegeom(hru)
#stencil <- webgeom('HUC8::09020306,14060009')
#stencil2<-webgeom(url='https://www.sciencebase.gov/catalogMaps/mapping/ows/54f5d2fee4b02419550d2fae?service=wfs&request=getcapabilities&version=1.0.0',
#                  geom="r06_bend120",attribute="hru_id",values=c('1:2462'))