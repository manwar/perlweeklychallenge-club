#!perl

###############################################################################
=comment

Perl Weekly Challenge 164
=========================

TASK #2
-------
*Happy Numbers*

Submitted by: Robert DiCicco

Write a script to find the first 8 Happy Numbers in base 10. For more informa-
tion, please check out [https://en.wikipedia.org/wiki/Happy_number |Wikipedia].

Starting with any positive integer, replace the number by the sum of the
squares of its digits, and repeat the process until the number equals 1 (where
it will stay), or it loops endlessly in a cycle which does not include 1.

Those numbers for which this process end in 1 are happy numbers, while those
numbers that do not end in 1 are unhappy numbers.

Example

19 is Happy Number in base 10, as shown:

  19 => 1^2 + 9^2
     => 1   + 81
     => 82 => 8^2 + 2^2
           => 64  + 4
           => 68 => 6^2 + 8^2
                 => 36  + 64
                 => 100 => 1^2 + 0^2 + 0^2
                        => 1 + 0 + 0
                        => 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Observations
------------
(1) From [2]: "In base 10, the 143 10-happy numbers up to 1000 are:
      1,   7,  10,  13,  19,  23,  28,   31,  32,  44,  49,  68,  70,  79,  82,
     86,  91,  94,  97, 100, 103, 109,  129, 130, 133, 139, 167, 176, 188, 190,
    192, 193, 203, 208, 219, 226, 230,  236, 239, 262, 263, 280, 291, 293, 301,
    302, 310, 313, 319, 320, 326, 329,  331, 338, 356, 362, 365, 367, 368, 376,
    379, 383, 386, 391, 392, 397, 404,  409, 440, 446, 464, 469, 478, 487, 490,
    496, 536, 556, 563, 565, 566, 608,  617, 622, 623, 632, 635, 637, 638, 644,
    649, 653, 655, 656, 665, 671, 673,  680, 683, 694, 700, 709, 716, 736, 739,
    748, 761, 763, 784, 790, 793, 802,  806, 818, 820, 833, 836, 847, 860, 863,
    874, 881, 888, 899, 901, 904, 907,  910, 912, 913, 921, 923, 931, 932, 937,
    940, 946, 964, 970, 973, 989, 998, 1000"

(2) Also from [2]:
    "...the only cycle is the eight-number cycle
        4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 → ..."
    "... all numbers either lead to 1 and are happy, or lead to the cycle and
     are unhappy."

Algorithm
---------
Test each positive integer n by calculating s_0, the sum of the squares of its
digits, and continue by testing s_0 to get s_1, s_1 to get s_2, etc., until
either:
 - s_n = 1, in which case s_n is now known to be a happy number; or
 - s_n is one of the numbers in the cycle described above in Observation (2),
   in which case s_n is now known to be an unhappy number.
Continue until the specified number of Happy Numbers has been found.

References
----------
[1] "A007770  Happy numbers: numbers whose trajectory under iteration of sum of
     squares of digits map (see A003132) includes 1.", OEIS,
     http://oeis.org/A007770
[2] "Happy number", Wikipedia, https://en.wikipedia.org/wiki/Happy_number

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Tiny;

const my $CYCLE  => Set::Tiny->new( qw[ 4 16 37 58 89 145 42 20 ] );
const my $TARGET => 8;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 164, Task #2: Happy Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die "Expected 0 command line arguments, found $args\n$USAGE";

    my @happy;

    for (my $n = 1; scalar @happy < $TARGET; ++$n)
    {
        my ($done, $last) = (0, $n);

        until ($done)
        {
            my $next = sum_of_squares( $last );

            if    ($next == 1)                                  # n is happy
            {
                push @happy, $n;
                $done = 1;
            }
            elsif ($CYCLE->has( $next ))                        # n is unhappy
            {
                $done = 1;
            }

            $last = $next;
        }
    }

    printf "The first %d 10-Happy Numbers:\n%s\n", $TARGET, join ', ', @happy;
}

#------------------------------------------------------------------------------
sub sum_of_squares
#------------------------------------------------------------------------------
{
    my ($n)   = @_;
    my  $sum  = 0;
        $sum += $_ * $_ for split '', $n;

    return $sum;
}

###############################################################################
