#!perl

################################################################################
=comment

Perl Weekly Challenge 327
=========================

TASK #1
-------
*Missing Integers*

Submitted by: Mohammad Sajid Anwar

You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given
array.

Example 1

  Input: @ints = (1, 2, 1, 3, 2, 5)
  Output: (4, 6)

  The given array has 6 elements.
  So we are looking for integers in the range 1..6 in the given array.
  The missing integers: (4, 6)

Example 2

  Input: @ints = (1, 1, 1)
  Output: (2, 3)

Example 3

  Input: @ints = (2, 2, 1)
  Output: (3)

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
use Regexp::Common qw( number  );
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
    print "\nChallenge 327, Task #1: Missing Integers (Perl)\n\n";
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

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $missing = find_missing_ints( \@ints );

        printf "Output: (%s)\n",          join ', ', @$missing;
    }
}

#-------------------------------------------------------------------------------
sub find_missing_ints
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my (@missing, %int_set);

    ++$int_set{ $_ } for @$ints;

    for my $i (1 .. scalar @$ints)
    {
        push @missing, $i unless exists $int_set{ $i };
    }

    return \@missing;
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

        my @ints     = split / \s+ /x, $ints_str;
        my $missing  = find_missing_ints( \@ints );
        my @expected = split / \s+ /x, $expd_str;

        is_deeply $missing, \@expected, $test_name;
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
Example 1| 1 2 1 3  2 5|4 6
Example 2| 1 1 1       |2 3
Example 3| 2 2 1       |3
None     | 1 2 3 4  5 6|
Negatives|-2 0 3 5 -4  |1 2 4
