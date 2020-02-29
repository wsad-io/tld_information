
echo "Uncompressing zonefiles"
cd ./zonefiles/zonefiles/

gunzip -r -f *

echo "Converting RAW txt files to Intermediate format"

for f in *.txt
do
   echo "Processing $f..."

   filename="${f%%.*}"

   sed 's/^/{'$filename'{/g' $f > $f.step1

   sed 's/$/}}/g' $f.step1 > $f.step2

   sed 's/[[:blank:]]/}{/g' $f.step2 > $filename.domain 

   echo "Cleaning up"

   wc -l $filename.domain

   rm $f.step1
   rm $f.step2

   echo "Done with $f - results saved to $filename.domain"

done

for f in *.domain
do
   wc -l $f
done




