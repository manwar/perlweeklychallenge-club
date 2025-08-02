#!perl

################################################################################
=comment

Perl Weekly Challenge 292
=========================

TASK #1
-------
*Twice Largest*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least
twice as big as every element in the given array. If it is return the index of
the largest element or return -1 otherwise.

Example 1

  Input: @ints = (2, 4, 1, 0)
  Output: 1

  The largest integer is 4.
  For every other elements in the given array is at least twice as big.
  The index value of 4 is 1.

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: -1

  The largest integer is 4.
  4 is less than twice the value of 3, so we return -1.

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
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( max );
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
    print "\nChallenge 292, Task #1: Twice Largest (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x  or error( qq["$_" is not a valid integer] )
            for @ints;

        max_is_unique( \@ints ) or error( 'The largest integer is not unique' );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $index = twice_largest( \@ints );

        print "Output: $index\n";
    }
}

#-------------------------------------------------------------------------------
sub twice_largest
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    return 0 if scalar @$ints == 1;

    my $idx = 0;
    my $max = $ints->[ 0 ];;

    for my $i (0 .. $#$ints)
    {
        if ($ints->[ $i ] > $max)
        {
            $idx = $i;
            $max = $ints->[ $i ];
        }
    }

    my @sorted = sort { $b <=> $a } @$ints;

    return $sorted[ 0 ] >= 2 * $sorted[ 1 ] ? $idx : -1;
}

#-------------------------------------------------------------------------------
sub max_is_unique
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $max   = max @$ints;
    my  $count = 0;

    $_ == $max && ++$count for @$ints;

    return $count == 1;
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

        my @ints  = split / \s+ /x, $int_str;
        my $index = twice_largest( \@ints );

        is $index, $expected, $test_name;
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
Example 1|2 4 1 0| 1
Example 2|1 2 3 4|-1
