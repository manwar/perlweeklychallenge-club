#!/opt/homebrew/bin/bash

declare -A chars

while read line
do    chars=()
      for ((i = 0; i < ${#line}; i ++))
      do  ch=${line:$i:1}
          if   [[ $ch =~ [a-z] ]]
          then ((chars[$ch] ++))
          fi
      done

      ((max_c = 0))
      ((max_v = 0))

      for ch in ${!chars[*]}
      do  count=${chars[$ch]}
          if   [[ $ch =~ [aeiou] ]]
          then cmp=max_c
          else cmp=max_v
          fi

          if   (($cmp < count))
          then eval "$cmp=$count"
          fi
      done

      echo $((max_c + max_v))
done
