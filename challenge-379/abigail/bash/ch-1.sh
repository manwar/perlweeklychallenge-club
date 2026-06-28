#!/opt/homebrew/bin/bash

while read line
do    rev=""
      for ((i = 0; i < ${#line}; i ++))
      do  rev=${line:$i:1}$rev
      done
      echo $rev
done
