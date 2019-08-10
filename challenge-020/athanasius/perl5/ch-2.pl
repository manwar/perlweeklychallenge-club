#!perl

################################################################################
=comment

Perl Weekly Challenge 020
=========================

Task #2
-------
Write a script to print the smallest pair of *Amicable Numbers*. For more infor-
mation, please checkout wikipedia
[ https://en.wikipedia.org/wiki/Amicable_numbers |page].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Math::Prime::Util qw( divisor_sum );

const my $PAIRS   => 1;                 # Number of amicable pairs to find
const my $PERFECT => 0;                 # Include perfect numbers in the output?
const my $USAGE   => "USAGE: perl $0 [--pairs <UInt>] [--perfect]\n";

BEGIN
{
    $| = 1;
    print "\n";
}

MAIN:
{
    my $pairs_target = $PAIRS;
    my $do_perfect   = $PERFECT;

    GetOptions
    (
        'pairs=i' => \$pairs_target,
         perfect  => \$do_perfect,

    ) or die $USAGE;

    $pairs_target > 0
        or die "Value \"$pairs_target\" invalid for option pairs (must be " .
               "greater than zero)\n$USAGE";

    my $pairs_found   =   0;
    my $perfect_found =   0;
    my %aliquot_sums  = ( 0 => 0 );

    for (my $n = 1; $pairs_found < $pairs_target; ++$n)
    {
        my $aliquot_sum = divisor_sum($n) - $n;

        $aliquot_sums{ $n } = $aliquot_sum;

        if ($aliquot_sum == $n)                          # n is a perfect number
        {
            printf "Perfect number #%d: %d\n", ++$perfect_found, $n
                if $do_perfect;
        }
        elsif (exists $aliquot_sums{ $aliquot_sum } &&   # n is the larger of an
                      $aliquot_sums{ $aliquot_sum } == $n)       # amicable pair
        {
            printf "Amicable pair %s#%d: (%d, %d)\n",
                    ($do_perfect ? ' ' : ''), ++$pairs_found, $aliquot_sum, $n;
        }
    }
}

################################################################################
