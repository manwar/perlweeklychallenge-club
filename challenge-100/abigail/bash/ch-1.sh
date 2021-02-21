#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

while read time
do    #
      # Extract the parts from the input.
      #
      ampm=${time//[0-9:]}
      hour=${time/:*}
      minutes=${time/*:}
      minutes=${minutes/[ap]m}

      #
      # We cannot have a leading 0 for "08" and "09", as
      # a number starting with a 0 in $(( )) expansion
      # is considered an octal number. For 00 .. 07, this
      # is fine. But 08 and 09 given an error.
      #
      if    [ "$hour" == "08" ]
      then  hour=8
      fi
      if    [ "$hour" == "09" ]
      then  hour=9
      fi

      #
      # Do the calculations.
      #
      if   [ "$ampm" == "am" ]
      then hour=$((hour == 12 ? 0 : hour))
           new_ampm=""
      fi
      if   [ "$ampm" == "pm" ]
      then hour=$((hour == 12 ? 12 : hour + 12))
           new_ampm=""
      fi
      if   [ "$ampm" == "" ]
      then if   [ $hour -ge 12 ]
           then new_ampm="pm"
           else new_ampm="am"
           fi
           hour=$((hour % 12 == 0 ? 12 : hour % 12))
      fi

      #
      # And print the results.
      #
      printf "%02d:%02d%s\n" $hour $minutes $new_ampm
done
