#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh
#


((count          = 10))
((nr_of_divisors =  8))

for ((n = 1; count > 0; n ++))
do  ((c = 0))
    for ((d = 1; c <= nr_of_divisors && d * d <= n; d ++))
    do  if   ((n % d == 0))
        then ((c = c + 2))
             if   ((d * d == n))
             then ((c = c - 1))
             fi
        fi
    done
    if   ((c == nr_of_divisors))
    then echo $n
         ((count = count - 1))
    fi
done
