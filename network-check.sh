#!/bin/bash
# use corn tab to schedule the task in intervals 
# If the site is down user gets email notification stating that user's website is down
if [ $# -ne 1 ]
then
MYSITE=www.chetandesign.net
else
MYSITE=$1
fi
ping -c 3 $MYSITE > /dev/null
if [ $? != 0 ]
then
echo `date +%F`
echo "Your site seems to be down"
mail -s "Your $MYSITE seems to be down" user@gmail.com
fi