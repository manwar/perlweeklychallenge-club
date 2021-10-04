#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

#
# Conversion functions from Wikipedia
#

function g2j (Y, M, D) {
    return (int ((1461 * (Y +    4800 + int ((M - 14) / 12))) /   4) +        \
            int ((367 * (M - 2 -   12 * int ((M - 14) / 12))) /  12) -        \
            int ((3 * int (((Y + 4900 + int ((M - 14) / 12))  / 100))) / 4) + \
            D - 32075)
}

function j2g (J) {
    e  = 4 * (J + 1401 + int (int ((4 * J + 274277) / 146097) * 3 / 4) - 38) + 3
    D =   int (((5 * (int ((e % 1461) / 4)) + 2) % 153) / 5) + 1
    M = ((int  ((5 * (int ((e % 1461) / 4)) + 2) / 153) + 2) % 12) + 1
    Y = int (e / 1461) - 4716 + int ((12 + 2 - M) / 12)
    return sprintf ("%04d/%02d/%02d", Y, M, D)
}

BEGIN {
    FS = "/"
    TODAY_Y = 2021
    TODAY_M =    9
    TODAY_D =   22

    julian_today = g2j(TODAY_Y, TODAY_M, TODAY_D)
}

{
    julian_then = g2j($1, $2, $3)
    print j2g(2 * julian_then  - julian_today) ", " \
          j2g(2 * julian_today - julian_then)
}
