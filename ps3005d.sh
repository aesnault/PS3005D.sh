#!/bin/sh

PORT="/dev/ttyACM0"
PROG=$(basename $0)
FILES=("init" "id" "get-volt" "get-vout" "get-current" "get-iout" "set-volt" "set-current" "enable-power" "disable-power"  "enable-volage-protection" "disable-volage-protection" "enable-current-protection" "disable-current-protection" )


if [ "Xmake-links" = "X$1" ] 
then
    
    for file in ${FILES[@]}
    do
            ln -s $0 $file
    done

fi

case $PROG in
    "init" )
         if [ -n $1 ]
         then
            PORT=$1 
         fi
         stty -F $PORT raw speed 9600 -ignpar cs8 -parenb -cstopb
         ;;
     "id" )
         echo -e -n "*IDN?" > $PORT ; read -n19 RESPONSE < $PORT 
         echo $RESPONSE
         ;;
     "get-volt" )
         echo -e -n "VSET1?" > $PORT ; read -n5 RESPONSE < $PORT 
         echo $RESPONSE
         ;;
     "get-vout" )
         echo -e -n "VOUT1?" > $PORT ; read -n5 RESPONSE < $PORT 
         echo $RESPONSE
         ;;
     "get-current" )
         echo -e -n "ISET1?" > $PORT ; read -n5 RESPONSE < $PORT 
         echo $RESPONSE
         ;;
     "get-iout" )
         echo -e -n "IOUT1?" > $PORT ; read -n5 RESPONSE < $PORT 
         echo $RESPONSE
         ;;
     "set-volt" )
         echo -e -n "VSET1:$1" > $PORT
         ;;
     "set-current" )
         echo -e -n "ISET1:$1" > $PORT
         ;;
     "enable-power" )
         echo -e -n "OUT1" > $PORT
         ;;
     "disable-power" )
         echo -e -n "OUT0" > $PORT
         ;;
     "enable-volage-protection" )
         echo -e -n "OVP1" > $PORT
         ;;
     "disable-volage-protection" )
         echo -e -n "OVP0" > $PORT
         ;;
     "enable-current-protection" )
         echo -e -n "OCP1" > $PORT
         ;;
     "disable-current-protection" )
         echo -e -n "OCP0" > $PORT
         ;;
esac
