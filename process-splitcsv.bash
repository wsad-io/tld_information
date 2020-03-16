#!/bin/bash


function processZonefiles()
	{
	cd zonefiles/zonefiles
	echo "Beginning Splitting CSV's"
	shopt -s nullglob
	for f in *.txt.csv
	do
	   filename="${f%%.*}.txt.csv"
	   NOW=$( date '+%F_%H_%M_%S' )
	   echo "Processing $f (TLD: $filename)"
	   echo "Splitting CSV into 90m chunks (for github) "
	   mkdir "${filename}.split"
	   mv ${filename} "${filename}.split/${filename}"
  	   cd "${filename}.split"
	   split -C 90m --numeric-suffixes $filename $filename.csv._
  	   echo "Removing source CSV"
	   rm $filename
	   git add $filename*._*
	   git commit -m "$filename.split.csv/* added to git on $NOW"
	   echo "Done with  " $filename
	   cd ..
	done
	cd ..
	cd ..
	}

processZonefiles








