#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function can_split (target, number, pow_10) {
    if (target >  number || target < 0) {return 0}
    if (target == number)               {return 1}

    pow_10 = 10

    while (pow_10 <= number) {
        if (can_split(target - (number % pow_10), int (number / pow_10))) {
            return 1
        }
        pow_10 *= 10
    }

    return 0
}

{
    print ($1 > 1 && can_split(sqrt ($1), $1) ? 1 : 0)
}
