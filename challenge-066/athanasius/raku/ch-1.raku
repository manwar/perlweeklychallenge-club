use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 066
=========================

Task #1
-------
*Divide Integers*

*Submitted by:* Mohammad S Anwar

You are given two integers $M and $N.

Write a script to divide the given two integers i.e. $M / $N without using
multiplication, division and mod operator and return the floor of the result of
the division.

*Example 1:*

 Input: $M = 5, $N = 2
 Output: 2

*Example 2:*

 Input: $M = -5, $N = 2
 Output: -3

*Example 3:*

 Input: $M = -5, $N = -2
 Output: 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    Int:D $M,                       #= Dividend (integer)
    Int:D $N where { $N },          #= Divisor (non-zero integer)
)
#===============================================================================
{
    "Challenge 066, Task #1: Divide Integers (Raku)\n".put;

    my Int $quotient = 0;

    if $M
    {
        my Num $ratio = ($M.abs.log - $N.abs.log).exp;

        $quotient = (($M > 0) && ($N > 0)  ||
                     ($M < 0) && ($N < 0)) ?? $ratio.floor !! -$ratio.ceiling;
    }

    "$M \\ $N = $quotient".put;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
