#!/opt/homebrew/bin/bash

declare -A nums

while read -a numbers
do    ((sum = 0))
      nums=()
      for ((i = 0; i < ${#numbers[@]}; i ++))
      do  ((sum += ${numbers[$i]}))
          nums[${numbers[$i]}]=1
      done
      ((res = sum < 0 ? 1 : 1 + sum / ${#numbers[@]}))
      while [[ ${nums[$res]} == 1 ]]
      do ((res = res + 1))
      done
      echo $res
done
