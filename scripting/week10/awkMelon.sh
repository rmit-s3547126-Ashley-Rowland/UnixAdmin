#!/bin/sh

awk '/'melon'/ { print $2,$3 }' mysampledata.txt
