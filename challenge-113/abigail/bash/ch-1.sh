#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

#     
# For a description of the algorithm, and the proof why this is correct:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html          
# 

gcds=(0 1 2 1 2 5 2 1 2 1)

while read N D
do    if   ((D == 0))
      then if ((N >= 100 || N % 10 == 0))
           then echo 1
           else echo 0
           fi
           continue
      fi
      if   ((N >= D * 10))
      then echo 1
           continue
      fi
      for  ((i = 0; i < D / gcds[D]; i ++))
      do   ((T = N - 10 * i - D))
           if  ((T >= 0 && T % D == 0))
           then echo 1
                continue 2
           fi
      done
      echo 0
done
