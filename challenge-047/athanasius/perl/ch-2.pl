#!perl

################################################################################
=comment

Perl Weekly Challenge 047
=========================

Task #2
-------
*Gapful Number*

Write a script to print first 20 Gapful Numbers greater than or equal to 100.
Please check out the [ https://oeis.org/A108343 |page] for more information
about Gapful Numbers.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $MINIMUM => 100;
const my $TARGET  =>  20;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $num   = $MINIMUM;
    my $count = 0;
    my @gapfuls;

    while ($count < $TARGET)
    {
        my $div = (split //, $num)[0] * 10 + $num % 10;

        if ($num++ % $div == 0)
        {
            push @gapfuls, $num - 1;
            ++$count;
        }
    }

    printf "The first %d Gapful Numbers greater than or equal to %d are:\n%s\n",
            $TARGET, $MINIMUM, join ', ', @gapfuls;
}

################################################################################
