#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# Read the maximum number from STDIN
#
chomp (my $MAX = <>);

#
# Generate the 5-smooth numbers up to $MAX.
# This does *NOT* generate the numbers is order. It does, however,
# generate all of them, and no other numbers.
#
#
# $base2 is of the form 2^i;              i       >= 0
# $base3 if of the form 2^i * 3^j;        i, j    >= 0
# $base5 is of the form 2^i * 3^j * 5^k;  i, j, k >= 0
#
for (my $base2 = 1; $base2 <= $MAX; $base2 *= 2) {
    for (my $base3 = $base2; $base3 <= $MAX; $base3 *= 3) {
        for (my $base5 = $base3; $base5 <= $MAX; $base5 *= 5) {
            say $base5;
        }
    }
}
