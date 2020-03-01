#!/bin/bash


function processZonefiles()
	{
	cd zonefiles/zonefiles
        HOST=54.188.121.97
        PORT=27018
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
	   mongoimport --db $DB --collection $filename --file $f --host $HOST --port $PORT --type $TYPE --fields=origin,ttl,in,type,rec,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,data16,data17,data18,data19,data20 

	   echo "Done with " $f
	done
	cd ..
	cd ..
	}

processZonefiles








