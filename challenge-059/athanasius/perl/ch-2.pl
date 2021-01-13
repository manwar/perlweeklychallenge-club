#!perl

################################################################################
=comment

Perl Weekly Challenge 059
=========================

Task #2
-------
*Bit Sum*

*Reviewed by Ryan Thompson*

*Helper Function*

For this task, you will most likely need a function f(_a_,_b_) which returns the
count of different bits of binary representation of _a_ and _b_.

For example, f(1,3) = 1, since:

Binary representation of 1 = 01

Binary representation of 3 = 11

There is only 1 different bit. Therefore the subroutine should return 1. Note
that if one number is longer than the other in binary, the most significant bits
of the smaller number are padded (i.e., they are assumed to be zeroes).

*Script Output*

You[r] script should accept _n_ positive numbers. Your script should sum the
result of f(_a_,_b_) for every pair of numbers given:

For example, given 2, 3, 4, the output would be *6*, since f(2,3) + f(2,4) +
f(3,4) = 1 + 2 + 3 = 6

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use feature      qw( bitwise );
use Const::Fast;
use Scalar::Util qw( looks_like_number );

const my $USAGE => "Usage:\n  $0 [<numbers> ...]\n\n" .
                   "    [<numbers> ...]    An even number of positive integers";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 059, Task #2: Bit Sum (Perl)\n\n";

    scalar @ARGV > 0      or die "ERROR: Missing arguments\n"       . $USAGE;
    scalar @ARGV % 2 == 0 or die "ERROR: Odd number of arguments\n" . $USAGE;

    for (@ARGV)
    {
        looks_like_number($_) && int == $_ && $_ >= 0
                          or die "ERROR: Invalid number $_\n"       . $USAGE;
    }

    my ($prob, $soln, $sum, $terms);

    while (scalar @ARGV > 0)
    {
        my $a_ = shift @ARGV;
        my $b_ = shift @ARGV;
        my $f  = f($a_, $b_);

        $prob .= ' + ' if $terms;
        $prob .= "f($a_,$b_)";
        $soln .= ' + ' if $terms++;
        $soln .= $f;
        $sum  += $f;
    }

    if ($terms == 1)
    {
        print "$prob = $sum\n";
    }
    else
    {
        print "$prob = $soln = $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub f
#-------------------------------------------------------------------------------
{
    return (sprintf '%b', $_[0] ^ $_[1]) =~ tr/1//;
}

################################################################################
