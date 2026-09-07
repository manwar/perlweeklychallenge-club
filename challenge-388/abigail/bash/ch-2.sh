#!/opt/homebrew/bin/bash


while read n
do    ((sf = 1))
      for ((i = 1; i <= n; i ++))
      do  ((sf = i * sf + 1 - 2 * (i % 2)))
      done
      echo $sf
done
