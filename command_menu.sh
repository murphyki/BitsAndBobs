#!/bin/sh

SCRIPT=$(readlink -f "$0")
WORKING_DIR=$(dirname "$SCRIPT")
LOGO="Menu Options"

# Define a function for invalid menu options
# parameters:
#  No parameters
unknown_menu_option () 
{
    MESSAGES="Invalid Selection ... Please Try Again" ; 
}

# Define a function to pause program execution
# parameters:
#  No parameters
pause () 
{
    echo
    echo "Press enter to continue or x|X to exit"
    local response=""
    read response
    
    if [ "$response" = "x" ] || [ "$response" = "X" ]
    then
        exit 0
    fi
}

# Define a function to do something
# parameters:
#  param1 - Some parameter...
#  param2 - Another parameter...
command1 ()
{
    echo "This is command 1"
}

# Define a function to do something
# parameters:
#  param1 - Some parameter...
#  param2 - Another parameter...
command2 ()
{
    echo "This is command 2"
}

# Define a function to do something
# parameters:
#  param1 - Some parameter...
#  param2 - Another parameter...
command3 ()
{
    echo "This is command 3"
}

# Define a function to display the main menu
# parameters:
#  No parameters
displaymenu () {
    clear
    echo "$(date)"
    echo "$LOGO"
    echo
    echo "1.  Run command 1"
    echo "2.  Run command 2"
    echo "3.  Run command 3"
    echo
    echo "x|X Exit"
    echo
    echo "$MESSAGES"
    echo
    echo "Select a menu option number and then ENTER"
    echo
}

# Program main
while  true
do
    displaymenu
    
    read menu_option

    MESSAGES=
     
    case $menu_option in
        1)      command1
                ;;
        2)      command2
                ;;
        3)      command3
                ;;
        x|X)    break
                ;;
        *)      unknown_menu_option
                ;;
    esac
    
    pause
done
