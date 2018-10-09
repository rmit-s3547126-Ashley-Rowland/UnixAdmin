#!/bin/bash

if [ -r $1 ]; then
  echo "File exists"
else
  echo "File does not exist"
fi

if [ ! -s $1 ]; then
  echo "File is empty"
else
  echo "File is not empty"
fi

