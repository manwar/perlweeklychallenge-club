use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 085
=========================

Task #1
-------
*Triplet Sum*

Submitted by: Mohammad S Anwar

You are given an array of real numbers greater than zero.

Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c <
2. Print 1 if you succeed otherwise 0.

Example 1:

 Input: @R = (1.2, 0.4, 0.1, 2.5)
 Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2

Example 2:

 Input: @R = (0.2, 1.5, 0.9, 1.1)
 Output: 0

Example 3:

 Input: @R = (0.5, 1.1, 0.3, 0.7)
 Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption:
A "triplet" is a *contiguous* sequence of 3 elements in the array.

Note:
If more than one triplet satisfies the requirement (and assuming $EXPLAIN is
set to a true value), then only the first such triplet will be shown in the
explanation.

=end comment
#==============================================================================

my Bool constant $EXPLAIN = True;

subset Positive of Real where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 085, Task #1: Triplet Sum (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@R where .all ~~ Positive:D  #= An array of real numbers greater than zero
)
##=============================================================================
{
    # Add zero to each real number to convert it to its decimal representation
    # (where possible); e.g., 0x10FE --> 4350 and 1e-4 --> 0.0001 but 1e-5 -->
    # 1e-05

    "Input:  @R = (%s)\n".printf: @R.map( { $_ + 0 } ).join: ', ';

    if my Int $idx = search-for-triplet(@R) < 0    # -ve index means no triplet
    {
        "Output: 0".put;
    }
    elsif $EXPLAIN
    {
        my Positive @triplet = @R[$idx .. $idx + 2];

        "Output: 1 as 1 < (%s = %f) < 2\n".printf:
            @triplet.join(' + '), @triplet.sum;
    }
    else
    {
        "Output: 1".put;
    }
}

#------------------------------------------------------------------------------
sub search-for-triplet( Array:D[Positive:D] $R --> Int:D )
#------------------------------------------------------------------------------
{
    my Int $idx = -1;     # Array index of the first triplet element; -1 = none

    if $R.elems >= 3
    {
        for 0 .. $R.end - 2 -> UInt $i
        {
            if 1 < $R[$i .. $i + 2].sum < 2
            {
                $idx = $i;
                last;
            }
        }
    }

    return $idx;
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
