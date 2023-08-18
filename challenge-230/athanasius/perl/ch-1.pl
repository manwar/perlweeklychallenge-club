#!perl

################################################################################
=comment

Perl Weekly Challenge 230
=========================

TASK #1
-------
*Separate Digits*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to separate the given array into single digits.

Example 1

  Input: @ints = (1, 34, 5, 6)
  Output: (1, 3, 4, 5, 6)

Example 2

  Input: @ints = (1, 24, 51, 60)
  Output: (1, 2, 4, 5, 1, 6, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is greater than zero.

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
    print "\nChallenge 230, Task #1: Separate Digits (Perl)\n\n";
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
            / ^ $RE{num}{int} $ /x
                   or error( qq["$_" is not a valid integer] );

            $_ > 0 or error( "$_ is not positive" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $digits = get_digits( \@ints );

        printf "Output: (%s)\n",          join ', ', @$digits;
    }
}

#-------------------------------------------------------------------------------
sub get_digits
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @digits;

    for my $int (@$ints)
    {
        push @digits, split '', $int;
    }

    return \@digits;
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
        my $digits   = get_digits( \@ints );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $digits, \@expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1|1 34  5  6|1 3 4 5 6
Example 2|1 24 51 60|1 2 4 5 1 6 0
