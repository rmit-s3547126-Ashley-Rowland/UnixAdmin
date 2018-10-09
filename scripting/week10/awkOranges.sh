#!/bin/sh

awk '$2 == "oranges" && $3 < 15 && $3 > 6 { print $1 }' mysampledata.txt
