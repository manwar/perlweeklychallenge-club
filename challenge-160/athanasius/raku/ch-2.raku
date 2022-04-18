use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 160
=========================

TASK #2
-------
*Equilibrium Index*

Submitted by: Mohammad S Anwar

You are give an array of integers, @n.

Write a script to find out the Equilibrium Index of the given array, if found.

    For an array A consisting n elements, index i is an equilibrium index if
    the sum of elements of subarray A[0…i-1] is equal to the sum of elements of
    subarray A[i+1…n-1].

Example 1:

  Input: @n = (1, 3, 5, 7, 9)
  Output: 3

Example 2:

  Input: @n = (1, 2, 3, 4, 5)
  Output: -1 as no Equilibrium Index found.

Example 3:

  Input: @n = (2, 4, 2)
  Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. The input list contains one or more elements (i.e., is not empty).
2. The sum of an empty subarray (i.e., a subarray with no elements) is zero.
   Therefore, the array @n = (3) has equilibrium index 0 because the subarrays
   to the left and right of its single element are empty, and so both sum to
   zero, making their sums equal.
3. If more than one index is an equilibrium index, only the first (i.e., the
   lowest) is output. For example, if @n = (0, 0, 0), then there are 3 equilib-
   rium indices: 0, 1, and 2; but only 0 will be given in the output.

Algorithm
---------
This bears some similarities to a sliding window technique. Each index is
checked in turn, beginning at index 0. The left sum is initially set to zero
(see Assumption 2 above), and the right sum is computed by summing all the
elements in the array except the first. If the sums are not equal, the "window"
moves 1 position to the right: the prospective equilibrium index i is incre-
mented, and the sums are adjusted by:
  - subtracting the value at the new index  i      from the  right sum; and
  - adding      the value at the     index (i - 1) to   the  left  sum.
This process continues until either:
  - an equilibrium index is found and output; or
  - the indices are exhausted, in which case there is no equilibrium index and
    the output is -1.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 160, Task #2: Equilibrium Index (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { .elems > 0 && .all ~~ Int:D }   #= A non-empty list of integers
)
#==============================================================================
{
    "Input:  @n = (%s)\n".printf: @n.join: ', ';

    my Int $index     = -1;
    my Int $left-sum  =  0;
    my Int $right-sum = [+] @n[ 1 .. @n.end ];

    for 0 .. @n.end -> UInt $i
    {
        if $left-sum == $right-sum
        {
            $index = $i;
            last;
        }

        $left-sum  += @n[ $i     ];
        $right-sum -= @n[ $i + 1 ] if $i < @n.end;
    }

    "Output: $index".put;
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
