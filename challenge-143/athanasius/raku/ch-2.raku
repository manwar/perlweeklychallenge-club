use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Set $VERBOSE to True (the default) to display an explanation of the result when
the output is 1. The explanation is modelled on Example 2.

Algorithm
---------
The subroutine get-factors() returns the factors of n as pairs (p, q) where
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

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 143, Task #2: Stealthy Number (Raku)\n".put;
}

#==============================================================================
class FactorPair
#==============================================================================
{
    has Pos $.p;
    has Pos $.q;
    has Pos $.sum;

    #--------------------------------------------------------------------------
    submethod BUILD( Pos:D :$!p, Pos:D :$!q )
    #--------------------------------------------------------------------------
    {
        $!sum = $!p + $!q;
    }
}

#==============================================================================
sub MAIN
(
    Pos:D $n                       #= A positive integer
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my FactorPair @pairs = get-factors( $n );

    @pairs.=sort: *.sum;

    my Bool $is-stealthy = False;
    my FactorPair ($factor1, $factor2);

    L-OUTER:
    for 0 .. @pairs.end - 1 -> UInt $idx-i
    {
        for $idx-i + 1 .. @pairs.end -> UInt $idx-j
        {
            if @pairs[ $idx-i ].sum + 1 == @pairs[ $idx-j ].sum
            {
                $factor1     = @pairs[ $idx-j ];
                $factor2     = @pairs[ $idx-i ];
                $is-stealthy = True;
                last L-OUTER;
            }
        }
    }

    "Output: %d\n".printf: $is-stealthy ?? 1 !! 0;

    explain( $n, $factor1, $factor2 ) if $VERBOSE && $is-stealthy;
}

#------------------------------------------------------------------------------
sub get-factors( Pos:D $n --> Array:D[FactorPair:D] )
#------------------------------------------------------------------------------
{
    my FactorPair @pairs;

    for 1 .. $n.sqrt.floor -> Pos $i
    {
        if $n %% $i
        {
            @pairs.push: FactorPair.new: p => $i, q => $n div $i;
        }
    }

    return @pairs;
}

#------------------------------------------------------------------------------
sub explain( Pos:D $n, FactorPair:D $factor1, FactorPair:D $factor2 )
#------------------------------------------------------------------------------
{
    my Pos $p1 = $factor1.p;
    my Pos $p2 = $factor2.p;
    my Pos $q1 = $factor1.q;
    my Pos $q2 = $factor2.q;

    ("\nSince %d * %d = %d * %d = %d " ~
         "and %d + %d = %d + %d + 1 = %d\n").printf:
            $p1, $q1, $p2, $q2, $n, $p1, $q1, $p2, $q2, $factor1.sum;
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
