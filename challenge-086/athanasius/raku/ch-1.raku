use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 086
=========================

Task #1
-------
*Pair Difference*

Submitted by: Mohammad S Anwar

You are given an array of integers @N and an integer $A.

Write a script to find if there exists a pair of elements in the array whose
difference is $A.

Print 1 if exists otherwise 0.

Example 1:

 Input: @N = (10, 8, 12, 15, 5) and $A = 7
 Output: 1 as 15 - 8 = 7

Example 2:

 Input: @N = (1, 5, 2, 9, 7) and $A = 6
 Output: 1 as 7 - 1 = 6

Example 3:

 Input: @N = (10, 30, 20, 50, 40) and $A = 15
 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption: The pair must be different (but possibly equal) elements in the
            array

Algorithm:  Exhaustive comparison of each pair difference, together with its
            negation, until a solution is found or all pairs have been examined

=end comment
#==============================================================================

my Bool constant $EXPLAIN = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 086, Task #1: Pair Difference (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    #| A possible difference between two elements in @N
    Int:D :$A!,

    #| An array of two or more integers
    *@N where { .all ~~ Int:D && @N.elems >= 2 }
)
##=============================================================================
{
    "Input:  @N = (%s) and \$A = %d\n".printf: @N.join(', '), $A;

    my Int ($minuend, $subtrahend) = find-pair(@N, $A);

    if $minuend.defined && $subtrahend.defined
    {
        if $EXPLAIN
        {
            "Output: 1 as $minuend - $subtrahend = $A".put;
        }
        else
        {
            'Output: 1'.put;
        }
    }
    else
    {
        'Output: 0'.put;
    }
}

#------------------------------------------------------------------------------
sub find-pair
(
    Array:D[Int:D] $N,
    Int:D          $A,
--> List:D[Int:D]
)
#------------------------------------------------------------------------------
{
    my Int ($minuend, $subtrahend);

    OUTER-FOR:
    for 0 .. $N.end - 1 -> Int $i
    {
        for $i + 1 .. $N.end -> Int $j
        {
            my Int $difference = $N[$i] - $N[$j];

            if    $difference ==  $A
            {
                $minuend    = $N[$i];
                $subtrahend = $N[$j];
                last OUTER-FOR;
            }
            elsif $difference == -$A
            {
                $minuend    = $N[$j];
                $subtrahend = $N[$i];
                last OUTER-FOR;
            }
        }
    }

    return [$minuend, $subtrahend];
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
