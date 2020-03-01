#!/bin/bash


function processZonefiles()
	{
	cd zonefiles/zonefiles
	echo "Beginning CSV conversion"
	for f in *.txt
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H_%M_%S' )

	   echo "Processing $f (TLD: $filename)"

	   echo "sed string replacement to CSV"
	   sed 's/[[:blank:]]/,/g' $f > $f.csv
	   echo "Removing original"
           rm $f
	   echo "Done with " $f
	done
	cd ..
	cd ..
	}

processZonefiles








