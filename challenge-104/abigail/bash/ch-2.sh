#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh
#

tokens=12
max_take=3

while ((tokens > 0))
do    s=""
      if ((tokens != 1))
      then s="s"
      fi
      printf "How many tokens do you take? (%2d token$s are left) " $tokens
      read take
      if ((1 <= take && take <= max_take))
      then takes=$((max_take + 1 - take))
           s=""
           if ((takes != 1))
           then s="s"
           fi
           printf "Computer takes %d token$s\n" $takes
           ((tokens -= (max_take + 1)))
      fi
done

echo "Computer wins"
