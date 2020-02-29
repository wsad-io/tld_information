#!/bin/bash


function buildClient()
	{
	#git pull git@github.com:icann/czds-api-client-java.git
	cd open-tld-downstream-client
	echo "Calling into maven to clean install (client_build.log)"
	mvn clean install  
	echo "Done"
	cd ..
	}

buildClient









