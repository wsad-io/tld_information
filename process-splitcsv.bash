#!/bin/bash


function processZonefiles()
	{
	cd zonefiles/zonefiles
	echo "Beginning Import to MongoDB, commiting to source tree and pre-processing"
	for f in *.txt
	do
	   filename="${f%%.*}"
	   NOW=$( date '+%F_%H_%M_%S' )
	   echo "Processing $f (TLD: $filename)"
	   echo "Splitting CSV into 90m chunks (for github) "
	   mkdir $filename.split.csv
  	   cd $filename.split.csv 
	   split -C 90m --numeric-suffixes ../$filename.csv $filename.csv._
	   cd ..
  	   echo "Removing source CSV"
	   rm $filename.csv
	   git add $filename.split.csv/*
	   git commit -m "$filename.split.csv/* added to git on $NOW"
	   echo "Done with  " $filename.split.csv
	done
	cd ..
	cd ..
	}

processZonefiles








