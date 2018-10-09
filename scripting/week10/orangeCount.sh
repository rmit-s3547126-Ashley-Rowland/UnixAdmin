#!/bin/sh

count=0;

awk '$2 == "oranges" {count+=$3 }' mysampledata.txt

echo "there are $count oranges in total"
