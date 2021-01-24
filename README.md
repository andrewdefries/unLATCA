# unLATCA
##
# Description

unLATCA is an open source project to un-lock the LATCA chemical library dataset for collaborative cheminformatics and chemical genetics

##
# Motivation 

1. [LATCA](http://www.thecutlerlab.org/2008/05/latca.html) is an acronym for Library of AcTive Chemicals on Arabidopsis. LATCA is both a chemical library and international collaborative project to screen and annotate curated and diverse chemical probes for plant chemical genetics/genomics, model,  non-model organisms and has established utility beyond the scope of plant biology.

1. The LATCA project has been influencial in the development of chemical genetics as a whole (see refs below), but does not have an appropriate public accessible database despite being hosted on [ChemMine](http://chemminedb.ucr.edu/compounds/Latca/).


1. It is logical and relevant to confederate annotation of LATCA into a database to merge findings with the larger chemical genetics/genomics ecosystem.

1. An open source database of LATCA will enable dissemination and examination of both the annotations of each chemical probe along with the impactful biological advances that have been inspired by active and inactive hits/leads within the collection. 

1. A public facing database will expand the impact of the LATCA project into larger datasets such as PubChem Bioassay, ToxCAST, DrugBank and commercially available compounds via ZINC to name a few.


1. The LATCA project has been the work of many dedicated technicians, graduate students, academic professionals and academic institutions across the world for over a decade. 

1. This project **unLATCA** will now be at the disposal of those in the existing collaborative network and encourage new comers to join, dissect, analyze and futher inspire future scientific advances in chemical biology.

##
#Procedure used to download LATCA from a public database [ChemMine](http://chemminedb.ucr.edu/compounds/Latca/).


Used a bash brace expansion to create a wget list for the 365 index pages in the database (./RunThis2Scrape.sh)

`echo http://chemminedb.ucr.edu/compounds/Latca/:{1..365}xxx | sed 's/xxx/\n/g' > ScrapeList.txt`

Downloaeded each html compound index page using wget supplied by the above list

`wget -i ScrapeList.txt`

Cleaned the html index pages down to just the urls for each compound

`grep "href\=\"/compounds/Latca/LAT" * | sed 's/^.*href\=\"\/compounds\/Latca\///g' | sed 's/\".*//' | sed 's/L/chemminedb\.ucr\.edu\/compounds\/Latca\/L/g' > FinalList.txt`

Removed duplicate entries

`sort FinalList.txt | uniq > RealFinalList.txt`

Used new list to obtain individual compound records

`wget -i RealFinalList.txt`

Made a for loop to go through each .html file and clean it for just the SDF (Structured Data File) data block containing the chemical structure and compound annotation (./Scrape2SDF.sh)

`list=(ls *.html*)

for i in "${list[@]}"

do

cat $i | sed -ne '/ISIS/,$p' | sed -e '/\$\$\$\$/,//d' | sed -e '$a\$\$\$\$' | sed 's/\&gt;/\>/g'  | sed 's/\&lt;/\</g' >> master.sdf

done
`

Imported master.SDF into R session ...




