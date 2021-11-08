#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read line
do  #
    # Calculate the sum of the squares of the digits. We'll ignore
    # any character which isn't a digit, and we ignore 0 as well
    # (as it won't contribute anything to the sum)
    #
    ((sum_of_squares = 0))
    for ((i = 0; i < ${#line}; i ++))
    do  char=${line:$i:1}
        if   test "0" "<" $char -a $char "<" ":"   # 1 - 9
        then ((sum_of_squares += char * char))
        fi
    done

    #
    # Find a smallest power of two whose square is larger than sum-of-squares
    #
    root_upper=1
    while ((root_upper * root_upper < sum_of_squares))
    do    ((root_upper = root_upper * 2))
    done

    #
    # Use binary search to zoom into the square of sum-of-squares.
    #
    ((root_lower = root_upper / 2))
    ((out = 0))
    while ((root_lower < root_upper))
    do    ((root_mid = (root_upper + root_lower) / 2))
          ((square_mid = root_mid * root_mid))
          if ((square_mid == sum_of_squares))
          then ((out = 1))
               ((root_lower = root_upper))
          else if   ((square_mid < sum_of_squares))
               then ((root_lower = root_mid + 1))
               else ((root_upper = root_mid))
               fi
          fi
    done
    echo $out
done
