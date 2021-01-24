echo http://chemminedb.ucr.edu/compounds/Latca/:{1..365}xxx | sed 's/xxx/\n/g' > ScrapeList.txt

wget -i ScrapeList.txt

grep "href\=\"/compounds/Latca/LAT" * | sed 's/^.*href\=\"\/compounds\/Latca\///g' | sed 's/\".*//' | sed 's/L/chemminedb\.ucr\.edu\/compounds\/Latca\/L/g' > FinalList.txt

sort FinalList.txt | uniq > RealFinalList.txt

wget -i RealFinalList.txt
