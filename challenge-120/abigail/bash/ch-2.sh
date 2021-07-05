#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

IFS=":"

DIFF_PER_MINUTE=11  # Half degrees
MIN_PER_HOUR=60
FULL_CIRCLE=720     # Half degrees

while read hours minutes
do    #
      # Bash is going to interpret an hour (or minute) of the form "08"
      # or "09" as an illegal octal number. So, we're going to use a
      # trick: we prepend a 1, and subtract 100.
      #
      ((hours   = "1$hours"   - 100))
      ((minutes = "1$minutes" - 100))
      ((angle = (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) %
                                            FULL_CIRCLE))
      if ((2 * angle >= FULL_CIRCLE))
      then ((angle = FULL_CIRCLE - angle))
      fi

      printf "%d" $((angle / 2))
      if ((angle % 2 == 1))
      then printf ".5"
      fi
      echo
done
