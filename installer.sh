#!/bin/sh

packege="default-jre";

if  !(dpkg -s $packege| grep -q  "Status: (install ok installed)");
then
	echo "$packege is already installed";
else
	apt-get install default-jre;
fi



