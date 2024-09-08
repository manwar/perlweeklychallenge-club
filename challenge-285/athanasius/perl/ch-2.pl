#!perl

################################################################################
=comment

Perl Weekly Challenge 285
=========================

TASK #2
-------
*Making Change*

Submitted by: David Ferrone

Compute the number of ways to make change for given amount in cents. By using
the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many
distinct ways can the total value equal to the given amount? Order of coin
selection does not matter.

  A penny (P) is equal to 1 cent.
  A nickel (N) is equal to 5 cents.
  A dime (D) is equal to 10 cents.
  A quarter (Q) is equal to 25 cents.
  A half-dollar (HD) is equal to 50 cents.

Example 1

  Input: $amount = 9
  Output: 2

  1: 9P
  2: N + 4P

Example 2

  Input: $amount = 15
  Output: 6

  1: D + 5P
  2: D + N
  3: 3N
  4: 2N + 5P
  5: N + 10P
  6: 15P

Example 3

  Input: $amount = 100
  Output: 292

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
2. An unsigned integer is entered on the command-line. This is the target amount
   (in cents) for making change.

Algorithm
---------
Distinct ways of making change for the target amount are calculated recursively.
The base case is reached whenever the largest coin to be considered is a penny.

As many of the recursive calls are identical, considerable savings can be made
through memoization (for large values of the target amount). To accomplish this,
the module Memoize is used, and the recursive subroutine make-change() is memo-
ized for target amounts of one thousand or more.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( max );
use Memoize;
use Regexp::Common qw( number );
use Test::More;

const my @COINS   => (50, 25, 10, 5, 1);
const my $MIN_MEM => 1e3;              # Minimum value of $amount at which memo-
                                       # ization makes a noticeable improvement
const my $USAGE   => <<END;
Usage:
  perl $0 <amount>
  perl $0

    <amount>    Amount of change in cents (unsigned integer)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 285, Task #2: Making Change (Perl)\n\n";
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
        my $amount =  $ARGV[ 0 ];
           $amount =~ / ^ $RE{num}{int} $ /x
                        or error( qq["$amount" is not a valid integer] );
           $amount >= 0 or error( "$amount is negative");

        print "Input:  \$amount = $amount\n";

        my $count = count_ways_to_make_change( $amount );

        printf "Output: %s\n", add_commas( $count );
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_ways_to_make_change                                 # Wrapper function
#-------------------------------------------------------------------------------
{
    my ($amount)  = @_;
    my  $max_coin = max( grep { $_ <= $amount } @COINS ) // 1;

    memoize( 'make_change' ) if $amount >= $MIN_MEM;

    return make_change( $amount, $max_coin );
}

#-------------------------------------------------------------------------------
sub make_change                                             # Recursive function
#-------------------------------------------------------------------------------
{
    my ($amount, $max_coin) = @_;
    my  $count = 0;

    if ($max_coin == 1)
    {
        ++$count;                                               # Base case
    }
    else
    {
        my $next_coin = max grep { $_ < $max_coin } @COINS;

        for (my $target = $amount; $target >= 0; $target -= $max_coin)
        {
            $count += make_change( $target, $next_coin );       # Recursive call
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
# Adapted from sub commify() at:
#   https://perldoc.perl.org/perlfaq5#How-can-I-output-my-numbers-with-commas-
#   added?
#
sub add_commas
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    1 while $n =~ s/ ^ (\+? \d+) (\d{3}) /$1,$2/x;

    return $n;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $amount, $expected) = split / \| /x, $line;

        for ($test_name, $amount, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $count = count_ways_to_make_change( $amount );

        is $count, $expected, $test_name;
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
Example 1  |  9|  2
Example 2  | 15|  6
Example 3  |100|292
Zero       |  0|  1
Penny      |  1|  1
Nickel     |  5|  2
Dime       | 10|  4
Quarter    | 25| 13
Half dollar| 50| 50
Forty-two  | 42| 31
