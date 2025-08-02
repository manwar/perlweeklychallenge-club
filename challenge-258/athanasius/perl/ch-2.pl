#!perl

################################################################################
=comment

Perl Weekly Challenge 258
=========================

TASK #2
-------
*Sum of Values*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @int and an integer $k.

Write a script to find the sum of values whose index binary representation has
exactly $k number of 1-bit set.

Example 1

  Input: @ints = (2, 5, 9, 11, 3), $k = 1
  Output: 17

  Binary representation of index 0 = 0
  Binary representation of index 1 = 1
  Binary representation of index 2 = 10
  Binary representation of index 3 = 11
  Binary representation of index 4 = 100

  So the indices 1, 2 and 4 have total one 1-bit sets.
  Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17

Example 2

  Input: @ints = (2, 5, 9, 11, 3), $k = 2
  Output: 11

Example 3

  Input: @ints = (2, 5, 9, 11, 3), $k = 0
  Output: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
$k is greater than or equal to zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. $k is given as the first command-line argument, followed by one or more
   elements of @ints.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <k> [<ints> ...]
  perl $0

    <k>             Target number of 1-digits in each index
    [<ints> ...]    Non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 258, Task #2: Sum of Values (Perl)\n\n";
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
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my  ($k, @ints) = @ARGV;

        for ($k, @ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        $k >= 0                    or error( '$k is negative' );

        printf "Input:  \@ints = (%s), \$k = %d\n", join( ', ', @ints ), $k;

        my $sum = find_sum( \@ints, $k );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub find_sum
#-------------------------------------------------------------------------------
{
    my ($ints, $k) = @_;
    my  $sum       = 0;

    for my $i (0 .. $#$ints)
    {
        my $binary   = sprintf '%b', $i;
        my $one_bits = $binary =~ tr/1/1/;

        $sum += $ints->[ $i ] if $one_bits == $k;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $k, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $k, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $int_str;
        my $sum  = find_sum( \@ints, $k );

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
Example 1| 2  5  9 11 3|1|17
Example 2| 2  5  9 11 3|2|11
Example 3| 2  5  9 11 3|0| 2
Singleton|42           |0|42
Negatives|-1 -3 -5 -7  |1|-8
