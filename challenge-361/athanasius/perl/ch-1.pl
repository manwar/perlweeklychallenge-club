#!perl

################################################################################
=comment

Perl Weekly Challenge 361
=========================

TASK #1
-------
*Zeckendorf Representation*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

    Every positive integer can be uniquely represented as sum of non-consecutive
    Fibonacci numbers.

Example 1

  Input: $int = 4
  Output: 3,1

  4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2

  Input: $int = 12
  Output: 8,3,1

  12 => 8 + 3 + 1

Example 3

  Input: $int = 20
  Output: 13,5,2

  20 => 13 + 5 + 2

Example 4

  Input: $int = 96
  Output: 89,5,2

  96 => 89 + 5 + 2

Example 5

  Input: $int = 100
  Output: 89,8,3

  100 => 89 + 8 + 3

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
2. A positive (non-zero) integer not greater than 100 is entered on the command-
   line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my @FIBONACCI => 1, 2, 3, 5, 8, 13, 21, 34, 55, 89;
const my $MAX_INT   => 100;
const my $USAGE     => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    An integer between 1 and 100
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 361, Task #1: Zeckendorf Representation (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $int = $ARGV[0];

        validate_input( $int );

        print  "Input:  \$int = $int\n";

        my $zeckendorf = find_zeckendorf_rep( $int );

        printf "Output: %s\n", join ',', @$zeckendorf;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_zeckendorf_rep
#-------------------------------------------------------------------------------
{
    my ($int) = @_;

    validate_input( $int );

    my  @zeckendorf;
    my  $index     = $#FIBONACCI;
    my  $remaining = $int;

    while ($remaining > 0)
    {
        --$index until $FIBONACCI[$index] <= $remaining;

        my $fib = $FIBONACCI[$index];

        push @zeckendorf, $fib;
        $remaining   -=   $fib;
    }

    return \@zeckendorf;
}

#-------------------------------------------------------------------------------
sub validate_input
#-------------------------------------------------------------------------------
{
    my ($int) = @_;

    $int =~ / ^ $RE{num}{int} $ /x
                     or error( qq["$int" is not a valid integer] );
    $int >= 1        or error( "The input integer $int is too small" );
    $int <= $MAX_INT or error( "The input integer $int is too large" );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int, $expected) = split / \| /x, $line;

        for ($test_name, $int, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $zeckendorf = find_zeckendorf_rep( $int );
        my @expected   = split ',', $expected;

        is_deeply $zeckendorf, \@expected, $test_name;
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
Example 1|  4|   3,1
Example 2| 12| 8,3,1
Example 3| 20|13,5,2
Example 4| 96|89,5,2
Example 5|100|89,8,3
