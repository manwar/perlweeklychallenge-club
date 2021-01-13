use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 083
=========================

Task #2
-------
*Flip Array*

Submitted by: Mohammad S Anwar

You are given an array @A of positive numbers.

Write a script to flip the sign of some members of the given array so that the
sum of the all members is minimum non-negative.

Given an array of positive elements, you have to flip the sign of some of its
elements such that the resultant sum of the elements of array should be minimum
non-negative (as close to zero as possible). Return the minimum no. of elements
whose sign needs to be flipped such that the resultant sum is minimum non-
negative.

Example 1:

 Input: @A = (3, 10, 8)
 Output: 1

Explanation:

 Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) +
 (8) = 1

Example 2:

 Input: @A = (12, 2, 10)
 Output: 1

Explanation:

 Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) +
 (10) = 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions:
1.  The input array is non-empty.
2.  A "positive number" here means an integer greater than zero.
3.  Both the final sum and the flip count are to be minimised, but minimising
    the final sum (i.e., the sum after some of the numbers have been flipped)
    takes priority over minimising the count of numbers to be flipped.

Algorithm:
    Brute force (i.e., exhaustive inspection of possible combinations), using
    Raku's built-in combinations() method.

=end comment
#==============================================================================

my Bool constant EXPLAIN = True;

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 083, Task #2: Flip Array (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@A where { @A.elems > 0 &&
                .all ~~ Pos:D }       #= A non-empty array of positive integers
)
##=============================================================================
{
    "  Input:  @A = (%s)\n".printf: @A.join: ', ';

    my Pos  $total-sum       = @A.sum;
    my UInt $min-flipped-sum = $total-sum;
    my Pos  @nums-to-flip;

    for @A.combinations -> List $comb
    {
        next if $comb.elems == 0 ||
                $comb.elems == @A.elems;

        my UInt $comb-sum    = $comb.sum;
        my Int  $flipped-sum = $total-sum - 2 * $comb-sum;

        next if $flipped-sum < 0;

        if    $flipped-sum <  $min-flipped-sum
        {
            $min-flipped-sum = $flipped-sum;
            @nums-to-flip    = $comb.split(/\s+/, :skip-empty).map: { .Int };
        }
        elsif $flipped-sum == $min-flipped-sum
        {
            my Pos @new-nums = $comb.split(/\s+/, :skip-empty).map: { .Int };

            if @new-nums.elems < @nums-to-flip.elems
            {
                @nums-to-flip = @new-nums;
            }
        }
    }

    my UInt $nums-to-flip = @nums-to-flip.elems;

    "  Output: $nums-to-flip".put;

    if EXPLAIN
    {
        "\nExplanation:".put;
        "  Flipping the sign of %d element%s %sgives the result %d\n".printf:
                $nums-to-flip,
                $nums-to-flip == 1 ?? '' !! 's',
                $nums-to-flip == 0 ?? '' !! "({ @nums-to-flip.join(', ') }) ",
                $min-flipped-sum;
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
