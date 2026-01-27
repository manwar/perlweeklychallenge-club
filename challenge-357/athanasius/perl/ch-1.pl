#!perl

################################################################################
=comment

Perl Weekly Challenge 357
=========================

TASK #1
-------
*Kaprekar Constant*

Submitted by: Mohammad Sajid Anwar

Write a function that takes a 4-digit integer and returns how many iterations
are required to reach Kaprekar's constant (6174). For more information about
Kaprekar's Constant please follow the [https://en.wikipedia.org/wiki/6174
|wikipedia page].

Example 1

  Input: $int = 3524
  Output: 3

  Iteration 1: 5432 - 2345 = 3087
  Iteration 2: 8730 - 0378 = 8352
  Iteration 3: 8532 - 2358 = 6174

Example 2

  Input: $int = 6174
  Output: 0

Example 3

  Input: $int = 9998
  Output: 5

  Iteration 1: 9998 - 8999 = 0999
  Iteration 2: 9990 - 0999 = 8991
  Iteration 3: 9981 - 1899 = 8082
  Iteration 4: 8820 - 0288 = 8532
  Iteration 5: 8532 - 2358 = 6174

Example 4

  Input: $int = 1001
  Output: 4

  Iteration 1: 1100 - 0011 = 1089
  Iteration 2: 9810 - 0189 = 9621
  Iteration 3: 9621 - 1269 = 8352
  Iteration 4: 8532 - 2358 = 6174

Example 5

  Input: $int = 9000
  Output: 4

  Iteration 1: 9000 - 0009 = 8991
  Iteration 2: 9981 - 1899 = 8082
  Iteration 3: 8820 - 0288 = 8532
  Iteration 4: 8532 - 2358 = 6174

Example 6

  Input: $int = 1111
  Output: -1

  The sequence does not converge on 6174, so return -1.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input integer must contain exactly 4 digits, but leading zeros are allowed.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-negative 4-digit integer is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;     # Enables strictures
use warnings;
use Const::Fast;
use List::Util   qw( all );
use Test::More;

const my $KAPREKAR   => 6174;
const my $MAX_ITERS  =>    7;
const my $NUM_DIGITS =>    4;
const my $USAGE      => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    A non-negative 4-digit integer
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 357, Task #1: Kaprekar Constant (Perl)\n\n";
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
        my $int =  $ARGV[0];
           $int =~ / ^ \d\d\d\d $ /x
                   or error( qq["$int" is not a valid 4-digit integer] );

        print "Input:  \$int = $int\n";

        my $iterations = count_iterations( $int );

        print "Output: $iterations\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_iterations
#-------------------------------------------------------------------------------
{
    my ($int) =  @_;
        $int  =~ / ^ \d\d\d\d $ /x
                 or die qq["$int" is not a valid 4-digit integer];

    my @digits = split //, $int;
    unshift @digits, 0 until scalar @digits == $NUM_DIGITS;

    return -1 if all { $digits[0] == $_ } @digits[1 .. $NUM_DIGITS - 1];

    my $count     = 0;
    my $iteration = $int;

    until ($iteration == $KAPREKAR)
    {
        my $max    = join '', sort { $b <=> $a } @digits;
        my $min    = join '', sort { $a <=> $b } @digits;
        $iteration = $max - $min;

        die 'ERROR: count too large' if ++$count > $MAX_ITERS;

        @digits = split //, $iteration;
        unshift @digits, 0 until scalar @digits == $NUM_DIGITS;
    }

    return $count;
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

        my $iterations = count_iterations( $int );

        is $iterations, $expected, $test_name;
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
Example 1|3524| 3
Example 2|6174| 0
Example 3|9998| 5
Example 4|1001| 4
Example 5|9000| 4
Example 6|1111|-1
Wikipedia|2111| 5
Max iters|2005| 7
