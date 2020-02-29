#!/bin/bash
function decompressZonefiles()
	{
	echo "Uncompressing zonefiles"
	cd ./zonefiles/zonefiles/

	for z in *.txt.gz
	do
	    echo "Uncompressing:\t"$z
	    time gunzip -r -f $z
	    echo "Done"
	done
	}


function processZonefiles()
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
	   NOW=$( date '+%F_%H_%M_%S' )

	   echo "Processing $f (TLD: $filename)"
   	   echo "mongo import zonefile direct to db (in background)"
	   mongoimport --db $DB --collection $filename_$now --file $f --host $HOST --port $PORT --type $TYPE --fields=origin,ttl,in,type,rec,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,data16,data17,data18,data19,data20 &

	   echo "sed string replacement to CSV"
	   sed 's/[[:blank:]]/,/g' $f > $filename.csv 
	  
	   echo "Splitting CSV into 90m chunks (for github) "
	   mkdir $filename.split.csv
  	   cd $filename.split.csv
	   split -C 90m --numeric-suffixes ../$filename.csv $filename.csv._
	   cd ..
	   echo "Done with " $f
	done

	}

decompressZonefiles
processZonefiles








