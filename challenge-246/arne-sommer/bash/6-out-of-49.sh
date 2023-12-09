#! /bin/bash

declare -A SIX

for (( ; ; ))
   do
    key=$(($RANDOM % 49 + 1))
    SIX[$key]=1

    if [ ${#SIX[*]} -gt 5 ]; then
      break
    fi
done

IFS=$'\n' sorted=($(sort -n <<<"${!SIX[*]}"))
unset IFS

for value in ${sorted[@]}; do
  echo "$value"
done
