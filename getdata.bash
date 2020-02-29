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

function buildClient()
	{
	#git pull git@github.com:icann/czds-api-client-java.git
	cd czds-api-client-java
	echo "Calling into maven to clean install (client_build.log)"
	mvn clean install  
	echo "Done"
	cd ..
	}

function startDownload()
	{
	cd czds-api-client-java
	echo "Executing zonefile download client"
	java -jar ./target/zonefile-downloader.jar -d ../zonefiles/
	cd ..
	}

function cleanData()
	{
	bash process.bash
	}

prepare
buildClient
startDownload
cleanData









