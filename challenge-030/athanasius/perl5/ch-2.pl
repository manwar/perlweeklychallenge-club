#!perl

################################################################################
=comment

Perl Weekly Challenge 030
=========================

Task #2
-------
Write a script to print all possible series of 3 positive numbers, where in each
series at least one of the number is even and sum of the three numbers is always
12. For example, *3,4,5*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
# Assumptions:
# (1) A "series" is a 3-tuple of (not necessarily distinct) numbers in monotonic
#     increasing order
# (2) "Positive" numbers are non-negative integers (i.e., whole numbers >= 0)
#
# Note: For all integers, even + even = even
#                         odd  + odd  = even
#                         even + odd  = odd
#                  and so odd  + odd  + odd = even + odd = odd
#     Since 12 is even, it cannot be formed by summing 3 odd numbers; therefore,
#     any series of 3 summing to 12 is guaranteed to include at least one even
#     number
#-------------------------------------------------------------------------------

use strict;
use warnings;
use feature qw( say );
use Const::Fast;

const my $SUM => 12;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    say "Monotonic ascending series of 3 positive numbers summing to $SUM:\n";

    my $count = 0;

    for my $i (0 .. $SUM)
    {
        for my $j ($i .. $SUM)
        {
            my $subtotal = $i + $j;

            for my $k ($j .. $SUM)
            {
                if ($subtotal + $k == $SUM)
                {
                    printf "(%d, %d, %2d)\t", $i, $j, $k;
                    ++$count;
                }
            }
        }
    }

    say "\n\nTotal: $count series";
}

################################################################################
