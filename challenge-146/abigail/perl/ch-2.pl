#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as: perl ch-2.pl < input-file
#

#
# Let's assume the "Curious Fraction Tree" is the one of Google's
# first hit, and which can unambiguously described as:
#
#     * The root is 1/1
#     * Each node a/b has children a/(a + b) and (a + b)/b
#
# without having to rely on an image which needs to be extrapolated.
# Of course, we also have to utterly ignore the existance of
# "the tree created similar to the above sample", as similar implies
# it being different.
#
# (PLEASE, PLEASE, PLEASE, spend 30 seconds more to make your challenges
# less ambiguous. Ambiguous challenges are not a feature, it's sloppiness).
#

while (<>) {
    my ($a, $b) = /[0-9]+/g;
    for (1, 2) {
        $a < $b ? ($b -= $a) : ($a -= $b);
        last unless $a && $b;
        print "$a/$b ";
    }
    print "\n";
}
