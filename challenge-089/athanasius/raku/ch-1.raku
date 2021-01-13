use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 089
=========================

Task #1
-------
*GCD Sum*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to sum [ https://en.wikipedia.org/wiki/Greatest_common_divisor |
GCD] of all possible unique pairs between 1 and $N.

Example 1:

 Input: 3
 Output: 3

 gcd(1,2) + gcd(1,3) + gcd(2,3)

Example 2:

 Input: 4
 Output: 7

 gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

From the Examples, it appears that "all possible unique pairs between 1 and $N"
should be interpreted to mean:

    all (i, j) such that 1 <= i < j <= N.

In the solution below, the GCD calculation is performed by Raku's inbuilt gcd
infix operator.

=end comment
#==============================================================================

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 089, Task #1: GCD Sum (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $N                    #= A positive integer
)
#==============================================================================
{
    "Input:  $N".put;

    my UInt $sum = 0;

    for 1 .. $N - 1 -> Positive $i
    {
        for $i + 1 .. $N -> Positive $j
        {
            $sum += $i gcd $j;
        }
    }

    "Output: $sum".put;
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
