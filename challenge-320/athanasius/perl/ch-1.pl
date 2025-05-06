#!perl

################################################################################
=comment

Perl Weekly Challenge 320
=========================

TASK #1
-------
*Maximum Count*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the maximum between the number of positive and negative
integers. Zero is neither positive nor negative.

Example 1

  Input: @ints = (-3, -2, -1, 1, 2, 3)
  Output: 3

  There are 3 positive integers.
  There are 3 negative integers.
  The maximum between 3 and 3 is 3.

Example 2

  Input: @ints = (-2, -1, 0, 0, 1)
  Output: 2

  There are 1 positive integers.
  There are 2 negative integers.
  The maximum between 2 and 1 is 2.

Example 3

  Input: @ints = (1, 2, 3, 4)
  Output: 4

  There are 4 positive integers.
  There are 0 negative integers.
  The maximum between 4 and 0 is 4.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers
END

my $vowels;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 320, Task #1: Maximum Count (Perl)\n\n";
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
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ARGV;

        my @ints = @ARGV;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $max_count = find_max_count( \@ints );

        print  "Output: $max_count\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_count
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $pos   = 0;
    my  $nil   = 0;
    my  $neg   = 0;

    for my $int (@$ints)
    {
        my $target = $int > 0 ? \$pos : $int == 0 ? \$nil : \$neg;
        ++$$target;
    }

    assert $pos + $nil + $neg == scalar @$ints;                   # Sanity check

    return $pos >= $neg ? $pos : $neg;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints      = split / \s+ /x, $int_str;
        my $max_count = find_max_count( \@ints );

        is $max_count, $expected, $test_name;
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
Example 1|-3 -2 -1 1 2 3|3
Example 2|-2 -1  0 0 1  |2
Example 3| 1  2  3 4    |4
