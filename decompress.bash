#!/bin/bash
function decompressZonefiles()
	{
	echo "Uncompressing zonefiles"
	cd ./zonefiles/zonefiles/

	for z in *.txt.gz
	do
	    echo "Uncompressing:\t"$z
	    time gunzip -r -f $z
	    echo "Done"
	done
	}


decompressZonefiles








