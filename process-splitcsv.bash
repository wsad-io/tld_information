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
	   split -C 90m --numeric-suffixes ../$f.csv $f.csv._
	   cd ..
  	   echo "Removing source CSV"
	   rm $f.csv
	   git branch $f >> /dev/null
	   git checkout $f
	   git pull
	   git add $f.split.csv/*
	   git commit -m "$f.split.csv/* added to git on $NOW"
	   git remote add github git@github.com:wsad-io/tld_information.git
	   git push github master
	   echo "Done with " $f
	done
	cd ..
	cd ..
	}

processZonefiles








