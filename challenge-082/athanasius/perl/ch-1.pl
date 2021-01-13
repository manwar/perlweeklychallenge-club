#!perl

###############################################################################
=comment

Perl Weekly Challenge 082
=========================

Task #1
-------
*Common Factors*

Submitted by: Niels van Dijke

You are given 2 positive numbers $M and $N.

Write a script to list all common factors of the given numbers.

Example 1:

 Input:
     $M = 12
     $N = 18

 Output:
     (1, 2, 3, 6)

 Explanation:
     Factors of 12: 1, 2, 3, 4, 6
     Factors of 18: 1, 2, 3, 6, 9

Example 2:

 Input:
     $M = 18
     $N = 23

 Output:
     (1)

 Explanation:
     Factors of 18: 1, 2, 3, 6, 9
     Factors of 23: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Is X a factor of X? In other words, is the "divides" relation reflexive? It is
usually thought so -- see https://en.wikipedia.org/wiki/Divisor -- but the
Examples in the Task description imply not. This leads to some anomalies, e.g.,
if 17 is not a factor of 17, then the only factor common to 17 and 34 is 1 and
17 itself is excluded.

In the solution given below, it is assumed that the divides relation IS reflex-
ive; but this can be changed by setting the constant "REFLEXIVE" to zero.

=cut
#==============================================================================

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Math::Prime::Util qw( divisors );
use Regexp::Common    qw( number );    # %RE{num}
use Set::Scalar;                       # infix "*" (overloaded for set inter-
                                       #             section), members(), new()
use constant
{
    REFLEXIVE => 1,
    VERBOSE   => 1,
};

const my $USAGE =>
"Usage:
  perl $0 <M> <N>

    <M>    First positive integer
    <N>    Second positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 082, Task #1: Common Factors (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($M, $N) = parse_command_line();

    printf "Input:\n    \$M = %d\n    \$N = %d\n\n", $M, $N;

    my $M_factors = Set::Scalar->new( divisors($M) );
       $M_factors->delete($M)                                 unless REFLEXIVE;

    my $N_factors = Set::Scalar->new( divisors($N) );
       $N_factors->delete($N)                                 unless REFLEXIVE;

    my @common = sort { $a <=> $b } ($M_factors * $N_factors)->members;

    printf "Output:\n    (%s)\n", join ', ', @common;

    explain($M, $N, $M_factors, $N_factors)                         if VERBOSE;
}

if (VERBOSE)
{
    #--------------------------------------------------------------------------
    sub explain
    #--------------------------------------------------------------------------
    {
        my ($M, $N, $M_factors, $N_factors) = @_;

        my @M_factors = sort { $a <=> $b } @$M_factors;
        my @N_factors = sort { $a <=> $b } @$N_factors;

        my $w = length($M) >= length($N) ? length($M) : length($N);

        print  "\nExplanation:\n";
        printf   "    Factors of %*d: %s\n",   $w, $M, join(', ', @M_factors);
        printf   "    Factors of %*d: %s\n\n", $w, $N, join(', ', @N_factors);

        printf qq[    Note: the "is a factor of" (or "divides", or "|") ] .
               qq[relation is here assumed\n          %sto be reflexive\n],
               REFLEXIVE ? '' : 'NOT ';
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args =  scalar @ARGV;
       $args == 2 or die "ERROR: Expected 2 command-line arguments, found " .
                         "$args\n$USAGE";

    for (@ARGV)
    {
        / \A $RE{num}{int} \z /x
                  or  die "ERROR: Non-integer '$_'\n$USAGE";

        $_ <  0   and die "ERROR: Negative integer '$_'\n$USAGE";

        $_ == 0   and die "ERROR: Zero is not a \"positive\" integer\n$USAGE";
    }

    return @ARGV;
}

###############################################################################
