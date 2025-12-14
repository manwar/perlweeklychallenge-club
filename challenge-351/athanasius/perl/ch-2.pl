#!perl

################################################################################
=comment

Perl Weekly Challenge 351
=========================

TASK #2
-------
*Arithmetic Progression*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form an
arithmetic progression, otherwise return false.

    A sequence of numbers is called an arithmetic progression if the difference
    between any two consecutive elements is the same.

Example 1

  Input: @num = (1, 3, 5, 7, 9)
  Output: true

  Already AP with common difference 2.

Example 2

  Input: @num = (9, 1, 7, 5, 3)
  Output: true

  The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3

  Input: @num = (1, 2, 4, 8, 16)
  Output: false

  This is geometric progression and not arithmetic progression.

Example 4

  Input: @num = (5, -1, 3, 1, -3)
  Output: true

  The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

Example 5

  Input: @num = (1.5, 3, 0, 4.5, 6)
  Output: true

  The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference
  1.5.

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
2. A non-empty list of numbers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<num> ...]
  perl $0

    [<num> ...]    A non-empty list of numbers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 351, Task #2: Arithmetic Progression (Perl)\n\n";
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
        my @num = @ARGV;

        / ^ $RE{num}{real} $ /x or error( qq["$_" is not a valid number] )
            for @num;

        printf "Input:  \@num = (%s)\n", join ', ', @num;

        my $arith_prog = is_arithmetic_progression( \@num );

        printf "Output: %s\n", $arith_prog ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub is_arithmetic_progression
#-------------------------------------------------------------------------------
{
    my ($num) = @_;

    if (scalar @$num > 1)
    {
        my @sorted     = sort { $a <=> $b } @$num;
        my $difference = $sorted[1] - $sorted[0];

        for my $i (2 .. $#sorted)
        {
            return 0 unless $sorted[$i] - $sorted[$i - 1] == $difference;
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num_str, $expected) = split / \| /x, $line;

        for ($test_name, $num_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @num        = split / \s+ /x, $num_str;
        my $arith_prog = is_arithmetic_progression( \@num ) ? 'true' : 'false';

        is $arith_prog, $expected, $test_name;
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
Example 1|1   3 5 7   9|true
Example 2|9   1 7 5   3|true
Example 3|1   2 4 8  16|false
Example 4|5  -1 3 1  -3|true
Example 5|1.5 3 0 4.5 6|true
