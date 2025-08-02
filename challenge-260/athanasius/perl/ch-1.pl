#!perl

################################################################################
=comment

Perl Weekly Challenge 260
=========================

TASK #1
-------
*Unique Occurrences*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return 1 if the number of occurrences of each value in the
given array is unique or 0 otherwise.

Example 1

  Input: @ints = (1,2,2,1,1,3)
  Output: 1

  The number 1 occurred 3 times.
  The number 2 occurred 2 times.
  The number 3 occurred 1 time.

  All occurrences are unique, therefore the output is 1.

Example 2

  Input: @ints = (1,2,3)
  Output: 0

Example 3

  Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
  Output: 1

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
2. One or more integers are given as arguments on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( uniqint );
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
    print "\nChallenge 260, Task #1: Unique Occurrences (Perl)\n\n";
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
        }

        printf "Input:  \@ints = (%s)\n", join ',', @ints;
        printf "Output: %d\n", unique_occurrences( \@ints );
    }
}

#-------------------------------------------------------------------------------
sub unique_occurrences
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    my %dict;
     ++$dict{ $_ } for @$ints;

    my @occurrences = values %dict;
    my @unique_occs = uniqint @occurrences;

    return (scalar @occurrences == scalar @unique_occs) ? 1 : 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my $unique   = unique_occurrences( \@ints );
        my $expected = ($expected_str eq '1') ? 1 : 0;

        is $unique, $expected, $test_name;
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
Example 1| 1 2 2  1 1 3         |1
Example 2| 1 2 3                |0
Example 3|-2 0 1 -2 1 1 0 1 -2 9|1
