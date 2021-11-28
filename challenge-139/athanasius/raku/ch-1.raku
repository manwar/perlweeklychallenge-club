use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 139
=========================

TASK #1
-------
*JortSort*

Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to implement JortSort. It should return true/false depending if
the given list of numbers are already sorted.

Example 1:

  Input: @n = (1,2,3,4,5)
  Output: 1

  Since the array is sorted, it prints 1.

Example 2:

  Input: @n = (1,3,2,4,5)
  Output: 0

  Since the array is NOT sorted, it prints 0.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

References
----------
1. https://jort.technology/
2. https://github.com/jennschiffer/jortsort
3. Rosetta Code (https://rosettacode.org/wiki/JortSort):
  "Note: jortSort is considered a work of satire. It achieves its result in an
   intentionally roundabout way. You are encouraged to write your solutions in
   the spirit of the original jortsort rather than trying to give the most
   concise or idiomatic solution."

Assumptions
--------------
Notwithstanding the Rosetta Code note quoted above, I consider the aim of the
task to be the efficient (and straightforward) determination of whether a given
list is sorted or not.

Although the examples show only natural numbers, I can see no reason to exclude
any real number from the list.

From the examples, it is clear that "sorted" means "sorted in ascending
numerical order". This still leaves open the question of how to classify a list
containing identical adjacent elements. I have assumed that "sorted" means "in
monotonically ascending order", so for a list such as (1, 2.5, 2.5, 3) the
expected output will be 1.

Algorithm
---------
The simplest approach I can think of is to compare each element F in the list
with its predecessor E: if F < E then the list is unsorted and the search ends
immediately. The worst case arises when the list is sorted (or when only the
final element is out of order): then the number of comparisons required will be
equal to the number elements in the list less one.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 139, Task #1: JortSort (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { .all ~~ Real:D }                           #= A list of numbers
)
#==============================================================================
{
    "Input:  \@n = (%s)\n".printf: @n.join: ', ';

    my Bool $sorted = True;

    for 1 .. @n.end -> UInt $i
    {
        if @n[ $i ] < @n[ $i - 1 ]
        {
            $sorted = False;
            last;
        }
    }

    "Output: %d\n".printf: $sorted ?? 1 !! 0;
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
