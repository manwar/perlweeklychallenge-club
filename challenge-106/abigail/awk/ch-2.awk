#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

#
# We're creation the decimal expansion of the fraction N / D
# by performing long division.
#
# First, we calculate the part before the decimal point, by
# doing integer division of N / D.
# We're then left to do division of N' / D, where N' initially
# is N % D.
# We then repeatedly find new digits by calculating the integer
# division of (10 * N' / D) (which gives us a new digit in the
# decimal expansion), and then setting N' = 10 * N' % D.
# The fraction will have a finite decimal expansion if during the
# process N' becomes 0. Otherwise, it repeats, and it repeats
# as soon as have a N' which we've already seen.
# To calculate the repeating part, we keep track of how far we
# were in calculating the expansion for which N'.
#
#     22/7     \0.318
#        0                      int (7 / 22) == 0, so 0 before decimal point
#        --
#        7                      N =       N  % D
#        66                     3 * D
#        --
#         4                     N = (10 * N) % D   <--+
#         22                    1 * D                 |
#         --                                          |  Same, so '18'
#         18                    N = (10 * N) % D      |  is the repeating
#         176                   8 * D                 |  part
#         ---                                         |
#           4                   N = (10 * N) % D   <--+
#
# This implementation is based on the one given on Wikipedia:
# https://en.wikipedia.org/wiki/Repeating_decimal.
#

function long_division (numerator, denominator) {
    base     = 10
    fraction = sprintf ("%d.", numerator / denominator)
    position = length (fraction)
    delete seen

    numerator %= denominator

    while (!seen [numerator]) {
        if (!numerator) {
            return fraction
        }
        seen [numerator] = position
        fraction  = fraction int (base * numerator / denominator)
        numerator =               base * numerator % denominator
        position ++
    }

    return substr (fraction, 1,  seen [numerator]) "(" \
           substr (fraction, 1 + seen [numerator]) ")"
}


{
    print long_division($1, $2)
}
