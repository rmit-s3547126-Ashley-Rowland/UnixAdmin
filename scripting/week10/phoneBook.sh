#!/bin/sh

case $1 in

  [Aa][n])
    echo 10 ;;

  [Jj][o])
    echo 11 ;;

  [Mm][a])
    echo 12 ;;

  [Rr][o])
    echo 13 ;;

  *)
    echo "Name not found in phone book"
esac
