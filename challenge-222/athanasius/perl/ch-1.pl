#!perl

################################################################################
=comment

Perl Weekly Challenge 222
=========================

TASK #1
-------
*Matching Members*

Submitted by: Mohammad S Anwar

You are given a list of positive integers, @ints.

Write a script to find the total matching members after sorting the list [in]
increasing order.

Example 1

  Input: @ints = (1, 1, 4, 2, 1, 3)
  Output: 3

  Original list: (1, 1, 4, 2, 1, 2)
  Sorted list  : (1, 1, 1, 2, 3, 4)

  Compare the two lists, we found 3 matching members (1, 1, 2).

Example 2

  Input: @ints = (5, 1, 2, 3, 4)
  Output: 0

  Original list: (5, 1, 2, 3, 4)
  Sorted list  : (1, 2, 3, 4, 5)

  Compare the two lists, we found 0 matching members.

Example 3

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 5

  Original list: (1, 2, 3, 4, 5)
  Sorted list  : (1, 2, 3, 4, 5)

  Compare the two lists, we found 5 matching members.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive integer" is an integer greater than zero.

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

    [<ints> ...]    A list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 222, Task #1: Matching Members (Perl)\n\n";
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
            $_ > 0                 or error( qq["$_" is not positive] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $matches = find_matches( \@ints );

        print "Output: $matches\n";
    }
}

#-------------------------------------------------------------------------------
sub find_matches
#-------------------------------------------------------------------------------
{
    my ($ints)   = @_;
    my  $matches = 0;
    my  @sorted  = sort { $a <=> $b } @$ints;

    for my $i (0 .. $#$ints)
    {
        ++$matches if $ints->[ $i ] == $sorted[ $i ];
    }

    return $matches;
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

        for ($test_name, $ints_str, $expected)                 # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints    = split / \s+ /x, $ints_str;
        my $matches = find_matches( \@ints );

        is $matches, $expected, $test_name;
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
Example 1|1 1 4 2 1 3|3
Example 2|5 1 2 3 4  |0
Example 3|1 2 3 4 5  |5
