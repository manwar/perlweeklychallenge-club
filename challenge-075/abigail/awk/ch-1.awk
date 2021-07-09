#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

function possibilities (target, from, to, sum, i) {
    if (target == 0)              {return 1}
    if (target <  0 || from > to) {return 0}

    sum = 0

    for (i = 0; i * coins [from] <= target; i ++) {
        sum += possibilities(target - i * coins [from], from + 1, to)
    }

    return sum
}

{
    for (i = 2; i <= NF; i ++) {
        coins [i] = $i
    }

    print (possibilities($1, 2, NF))
}


