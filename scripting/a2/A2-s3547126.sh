#!/bin/bash

#function that displays the main menu for user selection of led
function led_menu() {

    printf "Welcome to Led_Konfigurator!\\n"
    printf "==============================\\n"
    printf "Please select an led to configure:\\n"
    

    counter=0
    for led in /sys/class/leds/*; do
	printf "%d. ${led##*/} \\n" $counter
	counter=$((counter + 1))
    done
    printf "%d. Quit \\n" $counter

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
    printf "6) tquit to main menu\\n"
    printf "Please enter a number (1-6) for your choice:\\n"

}

#function that changes leds on/off | $1 for led name | $2 for status
function change_led() {
    
    echo "$2" > "/sys/class/leds/$1/brightness"


}




#run led selection menu
led_menu
