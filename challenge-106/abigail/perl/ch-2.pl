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
# Run as: perl ch-2.pl < input-file
#

#
# We are assuming the input consists of pairs of non-negative 
# integers, with the denominator greater than 0.
#

#
# To determine the repeating digits of a fraction, it's very tempting
# to use sprintf with a large amount of digits, and see what repeats.
# But Perl isn't precise enough even for small numbers to do so.
#
# For instance, 1/29 is 
#     .(0344827586206896551724137931)
#
# But sprintf "%.60f" => 1/29 gives:
#     0.034482758620689655171595968188857916914002998964861035346985
#
# Not only does it go wrong after 20 digits, there's no repetition.
# Furthermore, if we increase the precision, we find that all decimals
# after the 70th, are 0.
#

#
# We're creation the decimal expansion of the fraction $N / $D
# by performing long division. 
#
# First, we calculate the part before the decimal point, by
# doing integer division of $N / $D.
# We're then left to do division of $N' / $D, where $N' initially
# is $N % $D.
# We then repeatedly find new digits by calculating the integer
# division of (10 * $N' / $D) (which gives us a new digit in the
# decimal expansion), and then setting $N' = 10 * $N' % $D.
# The fraction will have a finite decimal expansion if during the
# process $N' becomes 0. Otherwise, it repeats, and it repeats
# as soon as have a $N' which we've already seen.
# To calculate the repeating part, we keep track of how far we
# were in calculating the expansion for which $N'.
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
#
sub long_division ($numerator, $denominator) {
    my $BASE     = 10;
    my $fraction = sprintf "%d." => $numerator / $denominator;
    my $position = length $fraction;
    my %seen;

    $numerator  %= $denominator;

    while (!$seen {$numerator}) {
        return $fraction unless   $numerator;  # No repeating part.
        $seen {$numerator} = $position;
        $fraction .= int ($BASE * $numerator / $denominator);
        $numerator =      $BASE * $numerator % $denominator;
        $position ++;
    }

    #
    # Place parens around the repetend part.
    #
    $fraction .= ")";
    substr $fraction, $seen {$numerator}, 0, "(";

    return $fraction;
}



say long_division split while <>;
