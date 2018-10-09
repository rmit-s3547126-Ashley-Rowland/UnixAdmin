#!/bin/sh
while getopts ":lpc:d:" opt; do
  case $opt in
       l)
         ls -l
         ;;

       p)
	 pwd
         ;;

       c)
	 cat "$OPTARG"
         ;;

       d)
	 cd "$OPTARG" || exit
	 ;;

       \?)
         echo "Invalid option: -$OPTARG" >&2
         ;;
  esac
done

