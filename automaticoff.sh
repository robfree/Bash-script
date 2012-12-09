#!/bin/bash

#**********************************************#
#  	        automaticoff.sh                    #
#	          Written by gdsr                    #
#		         July 27, 2009                     #
#					                                     #
#	        Program automatic shutdown           #
#**********************************************#


# Variables
ROOT_UID=0			# Only user with $UID 0 have root privileges.
E_NOTROOT=87			# Non-root error.
E_WRONG_ARGS=85			# Not parameters error.
SCRIPT_PARAMETERS="-s -c -h"	# Script-parameters.

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to run this script."
	exit $E_NOTROOT
	
fi

if [ $# -ne 1 ]
then
echo "Usage: `basename $0` $SCRIPT_PARAMETERS"
echo "`basename $0` -h for help"
# `basename $0` is the script's filename.
exit $E_WRONG_ARGS
fi

# Parameter -h  help 
if [ $1 == "-h" ] 
then
clear 
echo "Usage `basename $0` [-OPTIONS]"
echo "Options:"
echo 
echo " -h	for help."
echo " -s	for programing automatic shutdown."
echo " -c 	for cancel automatic shutdown." 
exit
fi

# Parameter -s shutdown
if [ $1 == "-s" ]
then
TIME=`zenity --entry \
        --title="Apagar el sistema" \
        --text="Introduce la hora de apagado (ej:16:30)" \
        --entry-text "HH:MM"`
echo $TIME
`shutdown -h $TIME` & zenity --notification \
	--window-icon="Info" \
	--text="Apagado del sistema programado a las $TIME horas."
exit
fi

# Parameter -c cancel
if [ $1 == "-c" ]
then
shutdown -c
fi
exit 0