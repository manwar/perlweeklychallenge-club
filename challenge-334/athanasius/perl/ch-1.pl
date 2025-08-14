#!perl

################################################################################
=comment

Perl Weekly Challenge 334
=========================

TASK #1
-------
*Range Sum*

Submitted by: Mohammad Sajid Anwar

You are given a list integers and pair of indices..

Write a script to return the sum of integers between the given indices (inclu-
sive).

Example 1

  Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
  Output: 1

  Elements between indices (0, 2) => (-2, 0, 3)
  Range Sum: (-2) + 0 + 3 => 1

Example 2

  Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
  Output: -3

  Elements between indices (1, 3) => (-2, 3, -4)
  Range Sum: (-2) + 3 + (-4) => -3

Example 3

  Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
  Output: 2

  Elements between indices (3, 4) => (-1, 3)
  Range Sum: (-1) + 3 => 2

Example 4

  Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
  Output: -2

  Elements between indices (0, 3) => (-5, 4, -3, 2)
  Range Sum: (-5) + 4 + (-3) + 2 => -2

Example 5

  Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
  Output: 1

  Elements between indices (0, 2) => (-1, 0, 2)
  Range Sum: (-1) + 0 + 2 => 1

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
2. Indices x and y are entered on the command-line as named parameters, followed
   by a non-empty list of integers.
3. The first negative integer in the list (if any) must be preceded by "--" to
   indicate that it is not a command-line flag.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $DEBUG => 1;
const my $USAGE => <<END;
Usage:
  perl $0 [-x[=UInt]] [-y[=UInt]] [<ints> ...]
  perl $0

    -x[=UInt]                  First  index
    -y[=UInt]                  Second index
    [<ints> ...]               A non-empty list of integers
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 334, Task #1: Range Sum (Perl)\n\n";
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
    elsif ($argc <  3)
    {
        error( "Expected 0 or 3+ command-line arguments, found $argc" );
    }
    else
    {
        my ($ints, $x, $y) = parse_command_line();

        printf "Input:  \@ints = (%s), \$x = $x, \$y = $y\n", join ', ', @$ints;

        my $sum = find_range_sum( $ints, $x, $y );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub find_range_sum
#-------------------------------------------------------------------------------
{
    my ($ints, $x, $y) = @_;

    validate_args( $ints, $x, $y ) if $DEBUG;

    my $sum = 0;

    for my $i ($x .. $y)
    {
        $sum += $ints->[ $i ];
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($x, $y);

    GetOptions
    (
        'x=i' => \$x,
        'y=i' => \$y

    ) or error( 'Invalid command-line arguments' );

    my @ints = @ARGV;

    validate_args( \@ints, $x, $y );

    return (\@ints, $x, $y);
}

#-------------------------------------------------------------------------------
sub validate_args
#-------------------------------------------------------------------------------
{
    my   ($ints, $x, $y) = @_;

    for (@$ints, $x, $y)
    {
        / ^ $RE{num}{int} $ /x
                        or error( qq["$_" is not a valid integer] );
    }

    $x            >= 0  or error( 'x is negative' );
    $y            >= 0  or error( 'y is negative' );
    $y            >= $x or error( 'x is greater than y' );
    scalar @$ints >  0  or error( 'The input list of integers is empty' );
    $#$ints       >= $y or error( 'y is too large for the list' );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $x, $y, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $x, $y, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $sum  = find_range_sum( \@ints, $x, $y );

        is $sum, $expected, $test_name;
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
Example 1|-2  0  3 -5  2 -1|0|2| 1
Example 2| 1 -2  3 -4  5   |1|3|-3
Example 3| 1  0  2 -1  3   |3|4| 2
Example 4|-5  4 -3  2 -1  0|0|3|-2
Example 5|-1  0  2 -3 -2  1|0|2| 1
