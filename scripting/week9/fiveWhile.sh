#!/bin/sh -x

HIGH=0
LOW=9999
counter=0

while [ -n "$1" ] && [ $counter -lt 5 ] ; do

  if [ "$1" -lt $LOW ] ; then
    LOW=$1
  fi

  if [ "$1" -gt $HIGH ] ; then
    HIGH=$1
  fi

  shift
  counter=$((counter+1))

done

echo "Lowest value supplied was: $LOW"
echo "Highest value supplied was: $HIGH"
