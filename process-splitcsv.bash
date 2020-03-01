#!/bin/bash


function processZonefiles()
	{
        HOST=192.168.86.27
        PORT=27017
        TYPE=tsv
        COLLECTION=tld_zonedata
        DB=publicDB
	cd zonefiles/zonefiles
	echo "Beginning Import to MongoDB, commiting to source tree and pre-processing"
	for f in *.txt
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H_%M_%S' )

	   echo "Processing $f (TLD: $filename)"
	   echo "Splitting CSV into 90m chunks (for github) "
	   mkdir $f.split.csv
  	   cd $f.split.csv
	   split -C 90m --numeric-suffixes ../$f.csv $.csv._
	   cd ..
	   echo "Done with " $f
	done

	}

processZonefiles








