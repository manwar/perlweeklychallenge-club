#!perl

################################################################################
=comment

Perl Weekly Challenge 245
=========================

TASK #2
-------
*Largest of Three*

Submitted by: Mohammad S Anwar

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the
given integers in any order which is also multiple of 3. Return -1 if none
found.

Example 1

  Input: @ints = (8, 1, 9)
  Output: 981

  981 % 3 == 0

Example 2

  Input: @ints = (8, 6, 7, 1, 0)
  Output: 8760

Example 3

  Input: @ints = (1)
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
Duplicates are allowed in the input list.

Observation
-----------
Any natural number represented in decimal (aka denary) notation is a multiple of
3 if and only if the recursive sum of its digits is also a multiple of 3.

    For example, 819 -> 8 + 1 + 9 = 18 -> 1 + 8 = 9, and 9 is a multiple of 3,
    so 819 has been shown to be a multiple of 3.

From this it follows that, for any given subset of the input integers, concaten-
ating and testing for multiplicity-of-3 will give the same result regardless of
the order in which the integers are concatenated. The solution below takes ad-
vantage of this fact by testing only the largest number which can be formed by
concatenating each possible subset. Since candidate solutions are evaluated in
order from largest to smallest, the first successful candidate is immediately
returned as the best solution.

=cut
#===============================================================================

use v5.32.1;                 # Enables strictures
use warnings;
use Algorithm::Combinatorics qw( combinations );
use Const::Fast;
use Regexp::Common           qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of integers >= 0\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 245, Task #2: Largest of Three (Perl)\n\n";
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

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( qq["$_" is negative] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $lot = largest_of_three( \@ints );

        print  "Output: $lot\n";
    }
}

#-------------------------------------------------------------------------------
sub largest_of_three
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;

    # Note the use of the *stringwise* comparison operator leg instead of <=>
    # here: this effectively sorts by digits, most- to least-significant,
    # rather than by total numerical value

    my  @sorted = sort { $b cmp $a } @$ints;

    for my $digits (reverse (1 .. scalar @sorted))
    {
        my $iter = combinations( \@sorted, $digits );

        while (my $comb = $iter->next)
        {
            my $candidate = join '', @$comb;

            return $candidate if $candidate % 3 == 0;
        }
    }

    return -1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $lot  = largest_of_three( \@ints );

        is $lot, $expected, $test_name;
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
Example 1|  8  1   9    |  981
Example 2|  8  6   7 1 0| 8760
Example 3|  1           |   -1
Multiples|  1  1   4 2  |  411
Small    |  8  2   9    |    9
Tens     | 81  9  10    |  981
Hundreds |198 30 500    |30198
