#!perl

################################################################################
=comment

Perl Weekly Challenge 052
=========================

Task #1
*Stepping Numbers*

Write a script to accept two numbers between 100 and 999. It should then print
all Stepping Numbers between them.

A number is called a stepping number if the adjacent digits have a difference of
1. For example, 456 is a stepping number but 129 is not.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $LOWER_LIMIT   =>  100;
const my $UPPER_LIMIT   =>  999;
const my $RANGE_ERROR   => "ERROR: Arguments must be between $LOWER_LIMIT " .
                           "and $UPPER_LIMIT\n";
const my @STEPPING_NUMS =>
         (
                  101, 121, 123,
             210, 212, 232, 234,
             321, 323, 343, 345,
             432, 434, 454, 456,
             543, 545, 565, 567,
             654, 656, 676, 678,
             765, 767, 787, 789,
             876, 878, 898,
             987, 989,
         );

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 052, Task #1: Stepping Numbers (Perl)\n\n";

    my $args = scalar @ARGV;

    $args == 2 or die "ERROR: Expected 2 command-line arguments, found $args\n";

    $_ >= $LOWER_LIMIT && $_ <= $UPPER_LIMIT or die $RANGE_ERROR for @ARGV;

    my ($lower, $higher) =  @ARGV;
       ($lower, $higher) = ($higher, $lower) if $lower > $higher;
    my  @solution;

    $lower <= $_ && $_ <= $higher and push @solution, $_ for @STEPPING_NUMS;

    if (scalar @solution == 0)
    {
        printf "There are no stepping numbers between %d and %d\n",
            $lower, $higher;
    }
    else
    {
        printf "The stepping numbers between %d and %d are:\n%s\n",
            $lower, $higher, join ', ', @solution;
    }
}

################################################################################
