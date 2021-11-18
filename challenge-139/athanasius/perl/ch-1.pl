#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<n> ...]

    [<n> ...]    A list of numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 139, Task #1: JortSort (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  \@n = (%s)\n", join ', ', @n;

    my $sorted = 1;

    for my $i (1 .. $#n)
    {
        if ($n[ $i ] < $n[ $i - 1 ])
        {
            $sorted = 0;
            last;
        }
    }

    print "Output: $sorted\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @n = @ARGV;

    for my $n (@n)
    {
        $n =~ / ^ $RE{num}{real} $ /x
            or die qq[ERROR: "$n" is not a valid number\n$USAGE];
    }

    return @n;
}

###############################################################################
