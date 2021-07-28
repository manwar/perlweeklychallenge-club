#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

declare -a ugly
ugly[0]=1
((next_2 = 0))
((next_3 = 0))
((next_5 = 0))
count=1

while read n
do  while ((count < n))
    do  ((c2 = 2 * ${ugly[next_2]}))
        ((c3 = 3 * ${ugly[next_3]}))
        ((c5 = 5 * ${ugly[next_5]}))

        if ((c2 <= c3 && c2 <= c5)); then ((ugly[count] = c2)); fi
        if ((c3 <= c2 && c3 <= c5)); then ((ugly[count] = c3)); fi
        if ((c5 <= c3 && c5 <= c2)); then ((ugly[count] = c5)); fi

        if ((2 * ${ugly[next_2]} <= ${ugly[count]})); then ((next_2 ++)); fi
        if ((3 * ${ugly[next_3]} <= ${ugly[count]})); then ((next_3 ++)); fi
        if ((5 * ${ugly[next_5]} <= ${ugly[count]})); then ((next_5 ++)); fi

        ((count ++))
    done
    echo ${ugly[$((n - 1))]}
done
