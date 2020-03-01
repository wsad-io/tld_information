#!/bin/bash


function processZonefiles()
	{
        HOST=192.168.86.27
        PORT=27017
        TYPE=tsv
        COLLECTION=tld_zonedata
        DB=publicDB
	cd zonefiles/zonefiles
	echo "Beginning CSV conversion"
	for f in *.txt
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H_%M_%S' )

	   echo "Processing $f (TLD: $filename)"

	   echo "sed string replacement to CSV"
	   sed 's/[[:blank:]]/,/g' $f > $f.csv
	   echo "Done with " $f
	done

	}

processZonefiles








