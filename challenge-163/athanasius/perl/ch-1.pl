#!perl

###############################################################################
=comment

Perl Weekly Challenge 163
=========================

TASK #1
-------
*Sum Bitwise Operator*

Submitted by: Mohammad S Anwar

You are given list positive numbers, @n.

Write script to calculate the sum of bitwise & operator for all unique pairs.

Example 1

  Input: @n = (1, 2, 3)
  Output: 3

  Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.

Example 2

  Input: @n = (2, 3, 4)
  Output: 2

  Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. "Positive numbers" are integers greater than zero.
2. "Unique pairs" are 2-combinations drawn from the *set* of input numbers,
    since:
      - the elements of each pair are distinct; and
      - their order is irrelevant.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::MoreUtils qw( uniq );
use Regexp::Common  qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  raku ch-1.raku [<n> ...]

    [<n> ...]    A list of positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 163, Task #1: Sum Bitwise Operator (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  \@n = (%s)\n", join ', ', @n;

    my $pairs = get_unique_pairs( \@n );
    my @bitw_ands;                  # Bitwise ANDs in the same order as @$pairs

    for my $pair (@$pairs)
    {
        my ($x, $y) = @$pair;

        push @bitw_ands, $x & $y;           # Perform the bitwise-AND operation
    }

    my $sum  = 0;
       $sum += $_ for @bitw_ands;

    print "Output: $sum\n";

    if ($VERBOSE && @$pairs)
    {
        my @pair_strs = map { sprintf "(%d & %d)", @$_ } @$pairs;

        printf "\nSince %s => %s => %d\n", join( ' + ', @pair_strs ),
                                           join( ' + ', @bitw_ands ), $sum;
    }
}

#------------------------------------------------------------------------------
sub get_unique_pairs
#------------------------------------------------------------------------------
{
    my ($n)   = @_;
    my  @nums = sort { $a <=> $b } uniq @$n;
    my  @pairs;

    for my $i (0 .. $#nums - 1)
    {
        for my $j ($i + 1 .. $#nums)
        {
            push @pairs, [ @nums[ $i, $j ] ];
        }
    }

    return \@pairs;           # These are in sorted (ascending numerical) order
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    @ARGV      or error( 'No command line arguments found' );

    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
               or error( qq["$n" is not a valid integer] );

        $n > 0 or error( qq["$n" is not positive] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
