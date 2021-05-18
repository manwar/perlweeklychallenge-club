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
# For any of the digits $D, more numbers $N can be written as a sum
# of positive integers, each containing the digit $D at least once.
#
# Let $D10 = $D == 0 ? 100 : $D * 10.
#
# It should be obvious that if $D > 0 and $N >= $D10, we can write $N as a 
# sum of integers each containing at least one $D:
#
#     For $D > 0:
#         Let  $N = $D * k + i,   k >= 10 and 0 <= i < $D,
#         then $N = $D10   + i + (k  - 10) * $D.
#
#         $D10 + i is a number containing exactly one $D, so $N can be
#         written as a sum of (k - 9) integers: 10 * $D + 1 and k - 10 $D's.
#
#     For $D = 0: 
#         Let $N = 100 + i + k * 10, for some 0 <= i < 10.
#       
#         100 + i will contain a 0, so $N can be written as a sum of
#         integers each containing a 0.
#
# It should also be clear that for $D > 0, if $N % $D == 0, $N can be
# written as a sum of integers containing $D, as $N is then a multiple of $D.
#
# For $N < $D10, $N can be written as a sum of positive integers
# containing at least one $D, iff:
#
#   1)  $N is divisible by $D (or $D10 if $D == 0)  OR
#   2)  $N - 10 * l is non-negative and divisible by $D,
#            for some 0 < l < $D.
#
# In case 1), $N is the sum of $N/$D $Ds.
# In case 2), $N is the sum of 10 * l + $D, and ($N - 10 * l - $D)/$D $Ds.
#
#
# We can further restrict which ls we have to check for a given $D:
#
#    $D  |  l
#   -----+-----
#     0  |
#     1  |
#     2  |  1
#     3  |  1, 2
#     4  |  1
#     5  |  
#     6  |  1, 2
#     7  |  1, 2, 3, 4, 5, 6
#     8  |  1, 2, 3
#     9  |  1, 2, 3, 4, 5, 6, 7, 8
#
# These are all the ls < $D so that $D does not divide 10 * l.

my @l = ([], [],       [1],      [1 .. 2], [1],
         [], [1 .. 2], [1 .. 6], [1 .. 3], [1 .. 8]);
my @tens = (0, 0, 1, 2, 1, 0, 2, 6, 3, 8);

MAIN: while (<>) {
    my ($N, $D) = /[0-9]+/g;
    my  $D10 = $D == 0 ? 100 : 10 * $D;
    if ($N >= $D10 || ($N % ($D || 10) == 0)) {
        say  1;
        next MAIN;
    }
    for (my $i = 1; $i <= $tens [$D]; $i ++) {
        my $T = $N - 10 * $i - $D;
        if ($T >= 0 && $T % $D == 0) {
            say  1;
            next MAIN;
        }
    }
    say 0;
}
