use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Is X a factor of X? In other words, is the "divides" relation reflexive? It is
usually thought so -- see https://en.wikipedia.org/wiki/Divisor -- but the
Examples in the Task description imply not. This leads to some anomalies, e.g.,
if 17 is not a factor of 17, then the only factor common to 17 and 34 is 1 and
17 itself is excluded.

In the solution given below, it is assumed that the divides relation IS reflex-
ive; but this can be changed by setting the constant $REFLEXIVE to False.

=end comment
#==============================================================================

my Bool constant $REFLEXIVE = True;
my Bool constant $VERBOSE   = True;

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 082, Task #1: Common Factors (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Pos:D $M,               #= First  positive integer
    Pos:D $N,               #= Second positive integer
)
##=============================================================================
{
    "Input:\n    \$M = $M\n    \$N = $N\n".put;

    my Set[Pos] $M-factors =  Set[Pos].new( find-divisors($M) );
    my Set[Pos] $N-factors =  Set[Pos].new( find-divisors($N) );
    my     Pos  @common    = ($M-factors ∩ $N-factors).keys.sort;

    "Output:\n    (%s)\n".printf: @common.join: ', ';

    explain($M, $N, $M-factors, $N-factors) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub find-divisors( Pos:D $number --> Array:D[Pos:D] )
#------------------------------------------------------------------------------
{
    my Pos @divisors = 1;

    for 2 .. $number.sqrt.floor -> Pos $i
    {
        if $number % $i == 0
        {
            my Pos $j = ($number / $i).floor;

            @divisors.push: $i;
            @divisors.push: $j unless $j == $i;
        }
    }

    @divisors.push: $number.Int if $REFLEXIVE;

    return @divisors;
}

#------------------------------------------------------------------------------
sub explain( Pos:D $M, Pos:D $N, Set:D[Pos:D] $M-facts, Set:D[Pos:D] $N-facts )
#------------------------------------------------------------------------------
{
    my $w = ($M.chars, $N.chars).max;

    "\nExplanation:".put;
    "    Factors of %*d: %s\n"\ .printf: $w, $M, $M-facts.keys.sort.join: ', ';
    "    Factors of %*d: %s\n\n".printf: $w, $N, $N-facts.keys.sort.join: ', ';

    (qq[    Note: the "is a factor of" (or "divides", or "|") ] ~
     qq[relation is here assumed\n          %sto be reflexive\n]).printf:
        $REFLEXIVE ?? '' !! 'NOT ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
