#!/bin/bash

function prepare()
	{
#	MAVEN_HOME="/usr/share/maven"
#	PATH=$PATH;$MAVEN_HOME/bin
	echo "Preparing folders"
	if [ ! -d "zonefiles" ]; then
		echo "Created ./zonefiles directory"
		mkdir ./zonefiles
		echo "Created ./zonefiles/zonefiles directory"
		mkdir ./zonefiles/zonefiles
	fi
	}


function startDownload()
	{
	cd open-tld-downstream-client
	echo "Executing zonefile download client"
	java -jar ./target/zonefile-downloader.jar -d ../zonefiles/
	cd ..
	}


prepare
startDownload









