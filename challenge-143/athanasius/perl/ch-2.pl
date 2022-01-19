#!perl

###############################################################################
=comment

Perl Weekly Challenge 143
=========================

TASK #2
-------
*Stealthy Number*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to find out if the given number is Stealthy Number.

    A positive integer N is stealthy, if there exist positive integers a, b, c,
    d such that a * b = c * d = N and a + b = c + d + 1.

Example 1

 Input: $n = 36
 Output: 1

 Since 36 = 4 (a) * 9 (b) = 6 (c) * 6 (d) and 4 (a) + 9 (b) = 6 (c) + 6 (d) +
 1.

Example 2

 Input: $n = 12
 Output: 1

 Since 2 * 6 = 3 * 4 and 2 + 6 = 3 + 4 + 1

Example 3

 Input: $n = 6
 Output: 0

 Since 2 * 3 = 1 * 6 but 2 + 3 != 1 + 6 + 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Set $VERBOSE to a true value (the default) to display an explanation of the
result when the output is 1. The explanation is modelled on Example 2.

Algorithm
---------
The subroutine get_factors() returns the factors of n as pairs (p, q) where
p * q = n. Each factor pair is summed, and the pairs are then sorted in ascend-
ing order of their sums. For example, if n = 36 then the sorted pairs are as
follows:
            -----------
             p   q sum
            -----------
             6   6  12
             4   9  13
             3  12  15
             2  18  20
             1  36  37
            -----------

A search is then conducted on the sums to find 2 sums which differ by exactly
1. In the above example, the search immediately finds 12 and 13, and the output
is 1, meaning 36 is a stealthy number. If no two sums differ by exactly 1, the
output is 0.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <n>

    <n>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 143, Task #2: Stealthy Number (Perl)\n\n";
}

#==============================================================================
package FactorPair
#==============================================================================
{
    #--------------------------------------------------------------------------
    sub new                                                       # Constructor
    #--------------------------------------------------------------------------
    {
        my ($class, $p, $q) = @_;

        my %self =
        (
            p   => $p,
            q   => $q,
            sum => $p + $q,
        );

        return bless \%self, $class;
    }

    #--------------------------------------------------------------------------
    # Read-only accessors
    #--------------------------------------------------------------------------
    
    sub p   { $_[ 0 ]->{ p   }; }
    sub q   { $_[ 0 ]->{ q   }; }
    sub sum { $_[ 0 ]->{ sum }; }
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    my $pairs = get_factors( $n );
      @$pairs = sort { $a->sum <=> $b->sum } @$pairs;

    my  $is_stealthy = 0;
    my ($factor1, $factor2);

    L_OUTER:
    for my $idx_i (0 .. $#$pairs - 1)
    {
        for my $idx_j ($idx_i + 1 .. $#$pairs)
        {
            if ($pairs->[ $idx_i ]->sum + 1 == $pairs->[ $idx_j ]->sum)
            {
                $factor1     = $pairs->[ $idx_j ];
                $factor2     = $pairs->[ $idx_i ];
                $is_stealthy = 1;
                last L_OUTER;
            }
        }
    }

    printf "Output: %d\n", $is_stealthy ? 1 : 0;

    explain( $n, $factor1, $factor2 ) if $VERBOSE && $is_stealthy;
}

#------------------------------------------------------------------------------
sub get_factors
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @pairs;

    for my $i (1 .. int sqrt $n)
    {
        if ($n % $i == 0)
        {
            push @pairs, FactorPair->new( $i, $n / $i );
        }
    }

    return \@pairs;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($n, $factor1, $factor2) = @_;
    my  $p1 = $factor1->p;
    my  $p2 = $factor2->p;
    my  $q1 = $factor1->q;
    my  $q2 = $factor2->q;

    printf "\nSince %d * %d = %d * %d = %d and " .
                   "%d + %d = %d + %d + 1 = %d\n",
            $p1, $q1, $p2, $q2, $n, $p1, $q1, $p2, $q2, $factor1->sum;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n > 0        or error( qq["$n" is not positive] );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
