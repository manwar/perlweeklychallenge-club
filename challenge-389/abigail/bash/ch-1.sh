#!/opt/homebrew/bin/bash

while read -a parts
do    notes=()
      for ((i = 1; i <= ${#parts[@]} / 2; i ++))
      do  notes[${parts[$((i + ${#parts[@]} / 2))]}]=${parts[$i]}
      done
      echo ${parts[0]@U}" => "${notes[@]}
done
