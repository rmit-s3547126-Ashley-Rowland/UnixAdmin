#!/bin/sh -x

high=0
low=9999
counter=0

for i in "$@" ; do

  if [ -z "$i" ] ; then
    break
  fi

  if [ "$i" -lt $low ] ; then
    low=$i
  fi

  if [ "$i" -gt $high ] ; then
    high=$i
  fi

  shift
  counter=$((counter+1))
done

echo "Lowest value supplied was: $low"
echo "Highest value supplied was: $high"
