#!perl

################################################################################
=comment

Perl Weekly Challenge 355
=========================

TASK #2
-------
*Mountain Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return true if the given array is a valid mountain array.

  An array is mountain if and only if:
  1) arr.length >= 3
  and
  2) There exists some i with 0 < i < arr.length - 1 such that:
  arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
  arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: false

Example 2

  Input: @ints = (0, 2, 4, 6, 4, 2, 0)
  Output: true

Example 3

  Input: @ints = (5, 4, 3, 2, 1)
  Output: false

Example 4

  Input: @ints = (1, 3, 5, 5, 4, 2)
  Output: false

Example 5

  Input: @ints = (1, 3, 2)
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

use constant True  => 1;
use constant False => !True;

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
    print "\nChallenge 355, Task #2: Mountain Array (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $is_mountain = is_mountain_array( \@ints );

        printf "Output: %s\n", $is_mountain ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub is_mountain_array
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    return False if scalar @$ints < 3 || $ints->[0] >= $ints->[1];

    my $going_up = True;
    my $previous = $ints->[1];

    for my $i (2 .. $#$ints)
    {
        my $current = $ints->[$i];

        return False if $current == $previous;

        if    ( $going_up && $current < $previous)
        {
            $going_up = False;
        }
        elsif (!$going_up && $current > $previous)
        {
            return False;
        }

        $previous = $current;
    }

    return !$going_up;
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

        my @ints        = split / \s+ /x, $ints_str;
        my $is_mountain = is_mountain_array( \@ints ) ? 'true' : 'false';

        is $is_mountain, $expected, $test_name;
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
Example 1|1 2 3 4 5    |false
Example 2|0 2 4 6 4 2 0|true
Example 3|5 4 3 2 1    |false
Example 4|1 3 5 5 4 2  |false
Example 5|1 3 2        |true
