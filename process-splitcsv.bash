#!/bin/bash


function processZonefiles()
	{
	cd zonefiles/zonefiles
	echo "Beginning Splitting CSV's"
	shopt -s nullglob
	for f in *.txt.csv
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H_%M_%S' )
	   echo "Processing $f (TLD: $filename)"
	   echo "Splitting CSV into 90m chunks (for github) "
	   mkdir "${filename}.split"
	   #mv ${filename} "${filename}.splig"
  	   cd "{$filename}.split"
	   split -C 90m --numeric-suffixes ../$filename.csv $filename.csv._
  	   echo "Removing source CSV"
#	   rm $filename.csv
	   git add .
	   git commit -m "$filename.split.csv/* added to git on $NOW"
	   echo "Done with  " $filename.split.csv
	   cd ..
	done
	cd ..
	cd ..
	}

processZonefiles








