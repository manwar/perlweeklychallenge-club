#!perl

################################################################################
=comment

Perl Weekly Challenge 326
=========================

TASK #2
-------
*Decompressed List*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers having even elements.

Write a script to return the decompress[ed] list. To decompress, pick adjacent
pair (i, j) and replace it with j, i times.

Example 1

  Input: @ints = (1, 3, 2, 4)
  Output: (3, 4, 4)

  Pair 1: (1, 3) => 3 one time  => (3)
  Pair 2: (2, 4) => 4 two times => (4, 4)

Example 2

  Input: @ints = (1, 1, 2, 2)
  Output: (1, 2, 2)

  Pair 1: (1, 1) => 1 one time  => (1)
  Pair 2: (2, 2) => 2 two times => (2, 2)

Example 3

  Input: @ints = (3, 1, 3, 2)
  Output: (1, 1, 1, 2, 2, 2)

  Pair 1: (3, 1) => 1 three times => (1, 1, 1)
  Pair 2: (3, 2) => 2 three times => (2, 2, 2)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
"Positive" integers are greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty, even-sized list of positive integers is entered on the command-
   line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( pairs );
use Regexp::Common qw( number  );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty, even-sized list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 326, Task #2: Decompressed List (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc % 2 == 0)
    {
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >  0                or error( "$_ is not positive" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $decompressed = decompress( \@ints );

        printf "Output: (%s)\n",          join ', ', @$decompressed;
    }
    else
    {
        error( 'The input list is not even in size' );
    }
}

#-------------------------------------------------------------------------------
sub decompress
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @decompressed;

    for my $pair (pairs @$ints)
    {
        push @decompressed, ($pair->value) x $pair->key;
    }

    return \@decompressed;
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

        my @ints         = split / \s+ /x, $ints_str;
        my $decompressed = decompress( \@ints );
        my @expected     = split / \s+ /x, $expected_str;

        is_deeply $decompressed, \@expected, $test_name;
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
Example 1|1 3 2 4|3 4 4
Example 2|1 1 2 2|1 2 2
Example 3|3 1 3 2|1 1 1 2 2 2
