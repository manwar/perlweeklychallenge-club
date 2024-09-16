#!perl

################################################################################
=comment

Perl Weekly Challenge 284
=========================

TASK #1
-------
*Lucky Integer*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there
are more than one then return the largest.

    A lucky integer is an integer that has a frequency in the array equal to its
    value.

Example 1

  Input: @ints = (2, 2, 3, 4)
  Output: 2

Example 2

  Input: @ints = (1, 2, 2, 3, 3, 3)
  Output: 3

Example 3

  Input: @ints = (1, 1, 1, 3)
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Negative integers are excluded.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of unsigned (i.e., non-negative) integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 284, Task #1: Lucky Integer (Perl)\n\n";
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

            $_ >= 0                or error( "$_ is negative" );
            $_ += 0;               # Normalize the elements (e.g. +5 --> 5)
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $lucky_int = find_lucky_int( \@ints );

        print  "Output: $lucky_int\n";
    }
}

#-------------------------------------------------------------------------------
sub find_lucky_int
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %freq;
      ++$freq{ $_ } for @$ints;

    # "If there are more than one [lucky number] then return the largest." To
    # accomplish this, the elements are tested in reverse order (highest first).

    for my $n (sort { $b <=> $a } @$ints)
    {
        return $n if $n == $freq{ $n };
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

        my @ints      = split / \s+ /x, $ints_str;
        my $lucky_int = find_lucky_int( \@ints );

        is $lucky_int, $expected, $test_name;
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
Example 1     |2 2 3 4    | 2
Example 2     |1 2 2 3 3 3| 3
Example 3     |1 1 1 3    |-1
Ex 2 reordered|3 3 3 2 2 1| 3
