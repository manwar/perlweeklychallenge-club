#!perl

################################################################################
=comment

Perl Weekly Challenge 233
=========================

TASK #2
-------
*Frequency Sort*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to sort the given array in increasing order based on the frequen-
cy of the values. If multiple values have the same frequency then sort them in
decreasing order.

Example 1

  Input: @ints = (1,1,2,2,2,3)
  Output: (3,1,1,2,2,2)

  '3' has a frequency of 1
  '1' has a frequency of 2
  '2' has a frequency of 3

Example 2

  Input: @ints = (2,3,1,3,2)
  Output: (1,3,3,2,2)

  '2' and '3' both have a frequency of 2, so they are sorted in decreasing or-
  der.

Example 3

  Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
  Output: (5,-1,4,4,-6,-6,1,1,1)

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

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 233, Task #2: Frequency Sort (Perl)\n\n";
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

        printf "Input: \@ints = (%s)\n", join ',', @ints;

        my $sorted = freq_sort( \@ints );

        printf "Output:        (%s)\n",  join ',', @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub freq_sort
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %freq;

    ++$freq{ $_ } for @$ints;

    return [ sort { $freq{ $a } <=> $freq{ $b } || $b <=> $a } @$ints ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $int_str;
        my @expected = split / \s+ /x, $exp_str;
        my $sorted   = freq_sort( \@ints );

        is_deeply $sorted, \@expected, $test_name;
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
Example 1| 1 1  2 2 2  3      |3  1 1 2  2  2
Example 2| 2 3  1 3 2         |1  3 3 2  2
Example 3|-1 1 -6 4 5 -6 1 4 1|5 -1 4 4 -6 -6 1 1 1
