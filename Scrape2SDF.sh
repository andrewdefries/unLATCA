rm master.sdf

list=(`ls *.html*`)

for i in "${list[@]}"

do

#echo $i

#echo "cat $i "

#echo "cat $i | sed -ne '/ISIS/,$p' | sed -e '/\$\$\$\$/,//d' | sed -e '$a\$\$\$\$' | sed 's/\&gt;/\>/g'  | sed 's/\&lt;/\</g' >> master.sdf"

cat $i | sed -ne '/ISIS/,$p' | sed -e '/\$\$\$\$/,//d' | sed -e '$a\$\$\$\$' | sed 's/\&gt;/\>/g'  | sed 's/\&lt;/\</g' >> master.sdf


done
