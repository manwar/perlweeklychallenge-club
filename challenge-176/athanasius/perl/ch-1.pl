#!perl

###############################################################################
=comment

Perl Weekly Challenge 176
=========================

TASK #1
-------
*Permuted Multiples*

Submitted by: Mohammad S Anwar

Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and
6x are permuted multiples of each other.

For example, the integers 125874 and 251748 are permutated multiples of each
other as

  251784 = 2 x 125874

  and also both have the same digits but in different order.

Output

  142857

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
Only positive integers are considered. Zero is excluded; otherwise, it would
be the smallest non-negative solution.

Interface
---------
If the constant $VERBOSE is set to a true value, the 6 multiples are printed to
allow visual confirmation that they are mutual permutations. If $VERBOSE is set
to a false value (the default), only the solution is displayed.

Algorithm
---------
Starting at 1, and counting upwards, each positive integer x is tested against
the criteria: is 6x a permutation of x?, is 5x a permutation of x?, and so on.
(Permutations are tested in reverse order because the larger multiples are more
likely to produce additional digits and therefore to fail sooner.) As soon as a
test fails, the remaining tests are bypassed and testing begins on the next x.
As this solution completes in about 1.3 seconds, further optimizations have not
been pursued (but see the Raku solution for a further possible optimization).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $USAGE   => "Usage:\n  perl $0\n";
const my $VERBOSE => 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 176, Task #1: Permuted Multiples (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my $x = 0;

    1 until is_pm6( ++$x );

    if ($VERBOSE)
    {
        printf 'The smallest non-zero, positive integer x such that x, 2x, ' .
               "3x, 4x, 5x and 6x\nare permuted multiples of each other is " .
               "%d:\n\n  %s\n",
                $x, join( "\n  ", map { "$_ * $x = " . $_ * $x } 1 .. 6 );
    }
    else
    {
        print  "$x\n";
    }
}

#------------------------------------------------------------------------------
sub is_pm6
#------------------------------------------------------------------------------
{
    my ($x) = @_;

    for my $i (reverse 2 .. 6)
    {
        return 0 unless are_permutations( $x, $i * $x );
    }

    return 1;
}

#------------------------------------------------------------------------------
sub are_permutations
#------------------------------------------------------------------------------
{
    my ($x, $y) = @_;

    return 0 unless length $x == length $y;

    my @digits_x = sort split //, $x;
    my @digits_y = sort split //, $y;

    for my $i (0 .. $#digits_x)
    {
        return 0 unless $digits_x[ $i ] eq $digits_y[ $i ];
    }

    return 1;
}

###############################################################################
