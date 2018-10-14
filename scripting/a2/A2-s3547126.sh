#!/bin/bash

#function that displays the main menu for user selection of led
function led_menu() {

    printf "Welcome to Led_Konfigurator!\\n"
    printf "==============================\\n"
    printf "Please select an led to configure:\\n"
    
    counter=1
    for led in /sys/class/leds/*; do
		leds[$counter]=${led##*/}
		printf "%d. %s\\n" $counter "${leds[$counter]}"
		((counter++))
	done

    printf "%d. Quit \\n" $counter

	read -r input

	if ((input >= 1)) && ((input < counter)) ; then
		led_control_menu "${leds[$input]}"
	elif [ "$input" == "$counter" ] ; then
		printf "Goodbye :)\\n"
		exit 1
	else
		printf "Error: please input a number between 1 and %s\\n" $counter
		led_menu
	fi
}

#function that displays the led manipulation menu
function led_control_menu() {

    printf "[%s]\\n" "$1"
    printf "===========\\n"
 	printf "What would you like to do with this led?\\n"
    printf "1) turn on\\n"
    printf "2) turn off\\n"
    printf "3) associate with system event\\n"
    printf "4) associate with the performance of a process\\n"
    printf "5) stop association with a process performance\\n"
    printf "6) quit to main menu\\n"
    printf "Please enter a number (1-6) for your choice:\\n"

	read -r input

	case $input in 

		1)
			change_led 1 ;;
		2)
			change_led 0 ;;
		3)
			associate_system_event "$1" ;;
		4)
			associate_process "$1" ;;
		5)
			stop_process_association ;;
		6)
			led_menu;;
		*)
			printf "Error: please input a number between 1 and 6\\n";;
	esac
}

#function that changes leds on/off | $1 for led name | $2 for status
function change_led() {
    
    echo "$2" > "/sys/class/leds/$1/brightness"


}

#function that associates led with system event | $1 for led name
function associate_system_event() {

    printf "Associate Led with a system event\\n"
	printf "=================================\\n"
	printf "Avaible events are:\\n"
	printf -- "-------------------\\n"
	
	counter=1
	line=$(head -n 1 /sys/class/leds/"$1"/trigger)			#grabs head of trigger file (since it's all on the initial line)
	IFS=" " read -ra events <<< "$line"						#splits events into array for access
	
	for i in "${events[@]}"; do								#displays all trigger events for current led
		if [[ $i == [* ]] && [ "${i: -1}" == "]" ] ; then
			printf "%d) %s* \\n" "$counter" "${i:1:-1}"
		else
			printf "%d) %s\\n" "$counter" "$i"
		fi
		counter=$((counter+1))
	done

	printf "%d) Quit to previous menu\\n" $counter			
	printf "Please select an option (1-%d)\\n" $counter

	read -r input

	if ((input >=1)) && ((input < counter)) ; then
		echo "${events[$input-1]}" | sudo tee /sys/class/leds/"$1"/trigger > /dev/null
		printf "%s assigned as trigger\\n" "${events[$input-1]}"
		led_control_menu "$1"
	elif [ "$input" == "$counter" ] ; then					#return to led control menu
		led_control_menu "$1"
	else
		printf "Error: please input a number between 1 and %d\\n" $counter
		associate_system_event "$1"
	fi
}

#function that creates the association of process performance to the Led
function associate_process() {

	printf "Associate LED with the performance of a process\\n"
	printf -- "-----------------------------------------------\\n"
	printf "Please enter the name of the program to monitor (partial names are ok):\\n"

	read -r input

	mapfile -t processes < <( pgrep -l "$input" )

	if ((${#processes[@]} > 1)) ; then
		
		printf "Name conflict!\\n"
		printf -- "--------------\\n"
		printf "I have detected a name conflict. Do you want to monitor (PID in brackets):\\n"
		
		counter=1
		for i in "${processes[@]}"; do
			IFS=" " read -ra split <<< "$processes" 
			printf "%d) %s(%s)\\n" $counter "${split[1]}" "${split[0]}"
			((counter++))
		done
		printf "%d) Cancel Request\\n" "$counter"

		read -r input

	elif ((${#split_processes[@]} == 1)) ; then
		background_resource_checker &
	else
		printf "Error: no process with that name (or partial name) were found\\n"
		led_control_menu "$1"
	fi
}

#function to be run in the background that periodically checks process performance
function background_resource_checker() {

	true

}

#run led selection menu (start of application)
led_menu
