#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

#
# Generate the 5-smooth numbers up to $0.
# This does *NOT* generate the numbers is order. It does, however,
# generate all of them, and no other numbers.
#
#
# base2 is of the form 2^i;              i       >= 0
# base3 if of the form 2^i * 3^j;        i, j    >= 0
# base5 is of the form 2^i * 3^j * 5^k;  i, j, k >= 0
#
{
    for (base2 = 1; base2 <= $0; base2 *= 2) {
        for (base3 = base2; base3 <= $0; base3 *= 3) {
            for (base5 = base3; base5 <= $0; base5 *= 5) {
                print base5
            }
        }
    }
}
