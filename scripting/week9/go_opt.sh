while getopts ":abc:d:" opt; do
  case $opt in
       a)
         echo "-a was triggered!" >&2
         ;;

       b)
         echo "-b was triggered!" >&2
         ;;

       c)
         echo "-c was triggered!" >&2
	 echo $OPTARG
         ;;

       d)
         echo "-d was triggered!" >&2
	 echo $OPTARG
	 ;;

       \?)
         echo "Invalid option: -$OPTARG" >&2
         ;;
  esac
done

