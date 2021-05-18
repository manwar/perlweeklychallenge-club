#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

tens=(0 0 1 2 1 0 2 6 3 8)

while read N D
do    ((D10 = D == 0 ? 100 : 10 * D))
      if ((N >= D10 || (N % (D == 0 ? 10 : D) == 0)))
      then echo 1
           continue
      fi
      for ((i = 1; i <= ${tens[$D]}; i ++))
      do  ((T = N - 10 * i - D))
          if  ((T >= 0 && T % D == 0))
          then echo 1
               continue 2
          fi
      done
      echo 0
done
           

