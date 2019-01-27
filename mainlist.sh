#!/bin/bash
WORKING=/home/pi/customlist

for i in $(cat $WORKING/hosts/easymain)
do
  wget -4 $i -O $WORKING/list/$(basename $i)
  cat $WORKING/list/$(basename $i) >> $WORKING/sorting/mainlist.txt
  rm -rf $WORKING/list/$(basename $i)
done
sort -u -o $WORKING/sorting/mainlist-s.txt $WORKING/sorting/mainlist.txt
for i in $(cat $WORKING/hosts/mediummain)
do
  wget -4 $i -O $WORKING/list/$(basename $i)
  grep -v "^#" $WORKING/list/$(basename $i) | awk -F' ' '{ print $2 }' >> $WORKING/sorting/mainlist-s.txt
  rm -rf $WORKING/list/$(basename $i)
done
sort -u -o $WORKING/sorting/mainlist.txt $WORKING/sorting/mainlist-s.txt
for i in $(cat $WORKING/hosts/lowmain)
do
  wget -4 $i -O $WORKING/list/$(basename $i)
  grep -v "^#" $WORKING/list/$(basename $i) | awk -F' ' '{ print $1 }' >> $WORKING/sorting/mainlist.txt
  rm -rf list/$(basename $i)
done
sort -u -o $WORKING/sorting/mainlist-s.txt $WORKING/sorting/mainlist.txt
sed -e '/^ *$/d' $WORKING/sorting/mainlist-s.txt | sed 's/\r$//' | grep -v ^$ > $WORKING/sorting/mainlist.txt

cp $WORKING/sorting/mainlist.txt /var/www/html/hosts/main.txt
chown pi:www-data /var/www/html/hosts/main.txt
