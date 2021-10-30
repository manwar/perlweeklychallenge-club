use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 136
=========================

TASK #1
-------
*Two Friendly*

Submitted by: Mohammad S Anwar

You are given 2 positive numbers, $m and $n.

Write a script to find out if the given two numbers are Two Friendly.

    Two positive numbers, m and n are two friendly when gcd(m, n) = 2 ^ p where
    p > 0. The greatest common divisor (gcd) of a set of numbers is the largest
    positive number that divides all the numbers in the set without remainder.

Example 1

    Input: $m = 8, $n = 24
    Output: 1

    Reason: gcd(8,24) = 8 => 2 ^ 3

Example 2

    Input: $m = 26, $n = 39
    Output: 0

    Reason: gcd(26,39) = 13

Example 3

    Input: $m = 4, $n = 10
    Output: 1

    Reason: gcd(4,10) = 2 => 2 ^ 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Include the flag "--verbose" on the command line to display an explanation of
the output.

Implementation
--------------
Calculation of the greatest common divisor is performed by Raku's inbuilt infix
operator "gcd".

=end comment
#==============================================================================

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 136, Task #1: Two Friendly (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $m,                          #= An integer > 0
    Positive:D $n,                          #= An integer > 0
    Bool:D    :$verbose = False             #= Explain the output?
)
#==============================================================================
{
    "Input:  \$m = $m, \$n = $n".put;

    my Bool     $friendly = False;
    my Str      $reason   = 'not a power of 2';
    my Positive $gcd      = $m gcd $n;

    if $gcd == 1
    {
        $reason = '2 ^ 0';
    }
    else
    {
        my Int $log2 = ($gcd.log2 + 0.5).Int;

        if $gcd == 2 ** $log2
        {
            $friendly = True;
            $reason   = "2 ^ $log2";
        }
    }

    "Output: %d\n".printf: $friendly ?? 1 !! 0;

    "\nReason: gcd($m, $n) = $gcd which is $reason".put if $verbose;
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
