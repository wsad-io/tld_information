#!/bin/bash
function decompressZonefiles()
	{
	echo "Uncompressing zonefiles"
	cd ./zonefiles/zonefiles/

	for z in *.txt.gz
	do
	    echo "Uncompressing: "$z
	    time gunzip -r -f $z
	    echo "Removing original" $z
	    echo "Done"
	done
	}


decompressZonefiles








