#!/bin/bash
# The Weekly Challenge - 120 
# Task 2 Clock Angle
# Usage: $ chmod +x ch-2.sh
#        $ ./ch-2.sh hh mm

# current time: date +"%H:%M"

hr_hand_inc_per_deg=2    #unit: minute per degree

minute_hand_rate=6       #unit: degree per minute

h=$1
m=$2

deg_h=$((($h*30+$m/$hr_hand_inc_per_deg)%360))
deg_m=$((($minute_hand_rate*$m)%360 ))
half=0
if [ $(($m%$hr_hand_inc_per_deg)) -eq 1 ];
then
    half=5
    if [ $deg_h -gt $deg_m ];
    then
        deg_h=$(($deg_h))
    else
        deg_h=$(($deg_h+1))
    fi
fi

if [ $deg_h -ge $deg_m ];
then
    deg=$(($deg_h-$deg_m))
else
    deg=$(($deg_m-$deg_h))
fi

if [ $deg -gt 180 ];
then
    if [ $half -eq 5 ];
    then
        deg=$((361-$deg))
    else
        deg=$((360-$deg))
    fi
fi

echo $deg.$half deg
