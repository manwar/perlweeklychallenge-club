#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    result = 0
    seen_one = 0
    split ($1, digits, "")
    for (i = 1; i <= length (digits); i ++) {
        result *= 9
        if (seen_one) {result += 8}
        else {
            if (digits [i] == 1) {seen_one = 1}
            else {
                if (digits [i] != 0) {result += digits [i] - 1}
            }
        }
    }
    print result
}
