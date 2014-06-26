#!/bin/sh

# Useful links:
#   http://www.tutorialspoint.com/unix/

# Variables
WORKING_DIR=$(pwd)
A_STRING="Hello World!"
A_NUMBER=0
echo "$WORKING_DIR"
echo "$A_STRING"

# Special shell variables
#   $0	The filename of the current script.
#   $n	These variables correspond to the arguments with which a script was invoked. Here n is a positive decimal number corresponding to the position of an argument (the first argument is $1, the second argument is $2, and so on).
#   $#	The number of arguments supplied to a script.
#   $*	All the arguments are double quoted. If a script receives two arguments, $* is equivalent to $1 $2.
#   $@	All the arguments are individually double quoted. If a script receives two arguments, $@ is equivalent to $1 $2.
#   $?	The exit status of the last command executed.
#   $$	The process number of the current shell. For shell scripts, this is the process ID under which they are executing.
#   $!	The process number of the last background command.

# If, ifelse, and case
# Integer comparison operators (inside square brackets): -eq, -ne, -gt, -ge, -lt, -le
# Integer comparison operators (inside round brackets): ==, !=, <, <=, >, >=
# String comparison operators: =, ==, !=, >, <
if [ $A_NUMBER -eq 0 ] 
then
    printf "1. %d is zero!\n" $A_NUMBER
fi

if [[ $A_NUMBER -eq 0 ]]; then
    printf "2. %d is zero!\n" $A_NUMBER
fi

if (( $A_NUMBER == 0 )); then
    printf "3. %d is zero!\n" $A_NUMBER
fi

if [ "$A_STRING" = "Hello World!\n" ]
then
    printf "4. %s is Hello World!\n" $A_STRING
fi

if [ "$A_NUMBER" -eq "1" ]
then
    printf "5. %d is one!\n" $A_NUMBER
elif [ "$A_NUMBER" -eq "2" ]
then
    printf "6. %d is two!\n" $A_NUMBER
else
    printf "7. %d is zero!\n" $A_NUMBER
fi

case $A_NUMBER in
    0 )	echo "8. Zero\n"
        ;;
    1 )	echo "9. One\n"
        ;;
    2 ) echo "10. 2\n"
        ;;
    * ) echo "11. Dunno what it is...\n"
        ;;
esac

# arrays
echo "Arrays..."
MY_ARRAY1=(1 2 3 4 5 6 7 8 9 10)
MY_ARRAY2[0]=1
MY_ARRAY2[1]=2
MY_ARRAY2[2]=3
MY_ARRAY2[3]=4
MY_ARRAY2[4]=5
MY_ARRAY2[5]=6
MY_ARRAY2[6]=7
MY_ARRAY2[7]=8
MY_ARRAY2[8]=9
MY_ARRAY2[9]=10

echo ${MY_ARRAY1[0]}
echo ${MY_ARRAY2[0]}

# access all elements in the array
# both syntaxes equivalent
echo ${MY_ARRAY1[*]}
echo ${MY_ARRAY2[@]}

echo "#elements in MY_ARRAY1 = ${#MY_ARRAY1[@]}"
echo "#elements in MY_ARRAY2 = ${#MY_ARRAY2[@]}"

# looping
echo "Looping..."
echo "first for loop syntax..."
for number in ${MY_ARRAY1[@]}
do
    printf "%d " $number
    # other stuff on $name
done

echo
echo "second for loop syntax..."
for (( i = 0 ; i < ${#MY_ARRAY2[@]} ; i++ ))
do
    printf "%d " ${MY_ARRAY2[$i]}
    # other stuff on $name
done

echo
echo "while loop syntax..."
count=1
while [ $count -le 9 ]
do
    printf "%d" $count
    (( count++ ))
done
echo


