#!perl

################################################################################
=comment

Perl Weekly Challenge 325
=========================

TASK #1
-------
*Consecutive One*

Submitted by: Mohammad Sajid Anwar

You are given a binary array containing only 0 or/and 1.

Write a script to find out the maximum consecutive 1 in the given array.

Example 1

  Input: @binary = (0, 1, 1, 0, 1, 1, 1)
  Output: 3

Example 2

  Input: @binary = (0, 0, 0, 0)
  Output: 0

Example 3

  Input: @binary = (1, 0, 1, 0, 1, 1)
  Output: 2

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
2. A non-empty list of binary digits is entered on the command-line.

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<binary> ...]
  perl $0

    [<binary> ...]    A non-empty list of binary digits
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 325, Task #1: Consecutive One (Perl)\n\n";
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
        my @binary = @ARGV;

        for (@binary)
        {
            $_ eq '0' || $_ eq '1' or error( qq["$_" is not a binary digit] );
        }

        printf "Input:  \@binary = (%s)\n", join ', ', @binary;

        my $max_ones = find_max_ones( \@binary );

        print  "Output: $max_ones\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_ones
#-------------------------------------------------------------------------------
{
    my ($binary) = @_;
    my  $string = join  '',     @$binary;
    my  @groups = split / 0 /x, $string;
    my  @sorted = sort @groups;

    return scalar @sorted == 0 ? 0 : length $sorted[ -1 ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $binary_str, $expected) = split / \| /x, $line;

        for ($test_name, $binary_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @binary   = split / \s+ /x, $binary_str;
        my $max_ones = find_max_ones( \@binary );

        is $max_ones, $expected, $test_name;
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
Example 1|0 1 1 0 1 1 1|3
Example 2|0 0 0 0      |0
Example 3|1 0 1 0 1 1  |2
