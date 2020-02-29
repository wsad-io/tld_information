#!/bin/bash

function prepare()
	{
	echo "Preparing folders"
	if [ ! -d "zonefiles" ]; then
		echo "Created ./zonefiles directory"
		mkdir ./zonefiles
		echo "Created ./zonefiles/zonefiles directory"
		mkdir ./zonefiles/zonefiles
	fi

	cd ./zonefiles/zonefiles

	if [ ! -d "data.old" ]; then
  		mkdir data.old
	fi
	mv * data.old >> /dev/null
	cd ..
	cd ..
	}

function buildClient()
	{
	echo "Calling into maven to clean install (client_build.log)"
	mvn clean install > client_build.log
	echo "Done"
	}

function startDownload()
	{
	echo "Executing zonefile download client"
	java -jar ./target/zonefile-downloader.jar
	}

function cleanData()
	{
	bash cleanData.sh
	}

prepare
buildClient
startDownload
cleanData









