#!perl

################################################################################
=comment

Perl Weekly Challenge 294
=========================

TASK #2
-------
*Next Permutation*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find out the next permutation of the given array.

    The next permutation of an array of integers is the next lexicographically
    greater permutation of its integer.

Example 1

  Input: @ints = (1, 2, 3)
  Output: (1, 3, 2)

  Permutations of (1, 2, 3) arranged lexicographically:
  (1, 2, 3)
  (1, 3, 2)
  (2, 1, 3)
  (2, 3, 1)
  (3, 1, 2)
  (3, 2, 1)

Example 2

  Input: @ints = (2, 1, 3)
  Output: (2, 3, 1)

Example 3

  Input: @ints = (3, 1, 2)
  Output: (3, 2, 1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.

Assumption
----------
Repetitions are allowed in the input list.

Algorithm
---------
From [1]: "The following algorithm generates the next permutation lexicographi-
cally after a given permutation. It changes the given permutation in-place.

   "1. Find the largest index k such that a[k] < a[k + 1]. If no such index
       exists, the permutation is the last permutation.
   "2. Find the largest index l greater than k such that a[k] < a[l].
   "3. Swap the value of a[k] with that of a[l].
   "4. Reverse the sequence from a[k + 1] up to and including the final element
       a[n]."

Reference
---------
[1] https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers

END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 294, Task #2: Next Permutation (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @ints = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $next = find_next_perm( \@ints );

        if (scalar @$next > 0)
        {
            printf "Output:         (%s)\n", join ', ', @$next;
        }
        else
        {
            print  "Output: This is the last permutation\n";
        }
    }
}

#-------------------------------------------------------------------------------
sub find_next_perm
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    # 1. Find the largest index k such that a[k] < a[k + 1]. If no such index
    #    exists, the permutation is the last permutation.

    my $k = -1;

    for my $i (reverse( 0 .. $#$ints - 1))
    {
        $k = $i, last if $ints->[ $i ] < $ints->[ $i + 1 ];
    }

    return [] if $k < 0;

    # 2. Find the largest index l greater than k such that a[k] < a[l]

    my $l;

    for my $i (reverse( $k + 1 .. $#$ints))
    {
        $l = $i, last if $ints->[ $k ] < $ints->[ $i ];
    }

    # 3. Swap the value of a[k] with that of a[l]

    @$ints[ $k, $l ] = @$ints[ $l, $k ];

    # 4. Reverse the sequence from a[k + 1] up to and including the final
    #    element a[n]

    @$ints[ $k + 1 .. $#$ints ] = reverse @$ints[ $k + 1 .. $#$ints ];

    return $ints;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $next = find_next_perm( \@ints );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $next, \@expd, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1| 1  2  3| 1  3  2
Example 2| 2  1  3| 2  3  1
Example 3| 3  1  2| 3  2  1
Inc 1st 1| 1  3  2| 2  1  3
Inc 1st 2| 2  3  1| 3  1  2
Negatives|-2 -1 -3|-1 -3 -2
Last perm| 3  2  1|
