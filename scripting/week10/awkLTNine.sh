#!/bin/sh

awk '$3 < 9 { print $2,$3 }' mysampledata.txt
