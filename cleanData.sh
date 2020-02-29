#!/bin/bash
function decompressZonefiles()
	{
	echo "Uncompressing zonefiles"
	cd ./zonefiles/zonefiles/

	for z in *.txt.gz
	do
	    echo "Uncompressing:\t"$z
	    gunzip -r -f $z
	    echo "Done"
	done
	}


function ConvertRawTxtToJson()
	{
        HOST=192.168.86.27
        PORT=27017
        TYPE=tsv
        COLLECTION=tld_zonedata
        DB=publicDB
	echo "Beginning Import to MongoDB, commiting to source tree and pre-processing"
	for f in *.txt
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H:%M:%S' )

	   echo "Adding $f to git"
	   git add $f > /dev/null
           git commit -m "Added latest TLD for $filename" > /dev/null &

	   echo "Processing $f (TLD: $filename)"
   	   echo "mongo import zonefile direct to db (in background)"
	   mongoimport --db $DB --collection $filename --file $f --host $HOST --port $PORT --type $TYPE --fields=origin,ttl,in,type,rec,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,data16,data17,data18,data19,data20 &

	   echo "Pre-processing..."
	   time sed 's/[[:blank:]]/,/g' $f > $filename.domain >> $filename.domain.timing

	   NOW=$( date '+%F_%H:%M:%S' )
	   echo "Committing" $filename.domain
	   git add $filename.domain > /dev/null
	   git commit -m "Pre-Processed $f to $filename.domain @ $NOW"  > /dev/null &

	   NOW=$( date '+%F_%H:%M:%S' )
           echo "Converting to JSON @ $NOW"
	   time csvtojson $filename.domain --noheader=true --alwaysSplitAtEOL=true --nullObject=true --ignoreEmpty=false --flatKeys=true --downstreamFormat=line >> $filename.json >> $filename.json.timing

	   NOW=$( date '+%F_%H:%M:%S' )
	   echo "Committing" $filename.json
	   git add $filename.json > /dev/null
           git commit -m "Converted $filename.domain to $filename.json @ $NOW"  > /dev/null &

	   NOW=$( date '+%F_%H:%M:%S' )
	   echo "Replacing Field Values (5 iterations) & cleanup"
	   # these are just to help identification
	   sed 's/"field1"/ORIGIN/g' $filename.json > $f.tmp1
	   sed 's/"field2"/TTL/g' $f.tmp1 > $f.tmp2
	   sed 's/"field3"/DNS_IN/g' $f.tmp2 > $f.tmp1
	   sed 's/"field4"/DNS_TYPE/g' $f.tmp1 > $f.tmp2
	   sed 's/"field5"/DATA_0/g' $f.tmp2 > $f.tmp1
	   sed 's/"field/DATA_/g' $f.tmp1 > $filename.json

	   rm $f.tmp1
	   rm $f.tmp2

	   NOW=$( date '+%F_%H:%M:%S' )
	   echo "Committing work"
	   git add $filename.json > /dev/null
           git commit -m "Added $filename.json from $f at $NOW"  > /dev/null &
	   echo "Done"
	done

	echo "Output:"
	ls -lr ./*.json | wc -l
	}


BRANCH=$( date '+%m-%d-$y--%h-%m-%s' )
echo "Creating and Switching to git branch automation/$NOW"
git branch automation/$BRANCH
git checkout automation/$BRANCH

decompressZonefiles
ConvertRawTxtToJson

echo "Switching to master branch"
git checkout master
echo "Merging our work"
git merge automation/$BRANCH









