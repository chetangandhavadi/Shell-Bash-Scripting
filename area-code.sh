#!/bin/bash
#United States and Canada Lookup

source="https://www.bennetyee.org/ucsd-pages/area.html"

if [ -z "$1" ] ; then
	echo "Include a three digit NPA: npa.sh XXX"
	exit 1
fi

if [ "$(echo $1 | wc -c)" -ne 4 ] ; then
	echo "NPA must be three digits."
	exit 1
fi

if [ ! -z "$(echo $1 | sed 's/[[:digit:]]//g')" ] ; then
	echo "Letters are are not compliant with NPA formatting."
	exit 1
fi

result="$(curl -s -dump $source | grep "name=\"$1" | \
	sed 's/<[^>]*>//g;s/^ //g' | \
	cut -f2- -d\ | cut -f1 -d\()"
	
echo "NPA $1 =$result"

exit