#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh [plain | compute]
#

set -f

COUNT=20

function divisor_sum () {
    sum=0
    local i
    for ((i = 2; i < n; i ++))
    do  if   ((n % i == 0))
        then ((sum += i))
        fi
    done
}

if   [ "X$1" != "Xcompute" ]
then echo "0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21"
else for ((n = 1; n <= COUNT; n ++))
     do  if   ((n > 1))
         then printf ", "
         fi
         divisor_sum $n
         printf $sum
     done
     echo ""
fi
