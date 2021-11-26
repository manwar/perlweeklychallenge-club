#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read i j k
do    ((n = 0))
      while ((k > 0))
      do ((n ++))
         for ((d = 1; d * d <= n && k > 0; d ++))
         do  if   ((n % d == 0))
             then if   ((d <= i && n / d <= j))
                  then ((k --))
                  fi
                  if   ((d <= j && n / d <= i))
                  then ((k --))
                  fi
                  if   ((n == d * d))
                  then ((k ++))
                  fi
             fi
         done
     done
     echo $n
done
