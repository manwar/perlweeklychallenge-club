use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An unsigned integer is entered on the command-line: this is the target amount
   (in cents) for making change.

Algorithm
---------
Distinct ways of making change for the target amount are calculated recursively.
The base case is reached whenever the largest coin to be considered is a penny.

As many of the recursive calls are identical, considerable savings can be made
through memoization (for large values of the target amount). To accomplish this,
the module Sub::Memoized is used, and the recursive subroutine make-change() is
given the trait "is memoized".

=end comment
#===============================================================================

use Sub::Memoized;
use Test;

my constant @COINS = Array[UInt].new: 50, 25, 10, 5, 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 285, Task #2: Making Change (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $amount               #= Amount of change in cents (unsigned integer)
)
#===============================================================================
{
    "Input:  \$amount = $amount".put;

    my UInt $count = count-ways-to-make-change( $amount );

    "Output: %s\n".printf: add-commas( $count );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-ways-to-make-change( UInt:D $amount --> UInt:D )    # Wrapper function
#-------------------------------------------------------------------------------
{
    my UInt $count = 1;

    if $amount > 1
    {
        my UInt $max-coin = @COINS.grep( { $_ <= $amount } ).max;

        $count = make-change( $amount, $max-coin );
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub make-change( UInt:D $amount, UInt:D $max-coin --> UInt:D ) is memoized
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    if $max-coin == 1
    {
        ++$count;                                               # Base case
    }
    else
    {
        my UInt $next-coin = @COINS.grep( { $_ < $max-coin } ).max;

        loop (my Int $target = $amount; $target >= 0; $target -= $max-coin)
        {
            $count += make-change( $target, $next-coin );       # Recursive call
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
# Adapted from the Rosetta Code commatize() subroutine at:
#   https://rosettacode.org/wiki/Commatizing_numbers#Raku
#
sub add-commas( UInt:D $n --> Str:D )
#-------------------------------------------------------------------------------
{
    return $n.subst: :continue( 0 ),
                     :1st,
                     / <[ 1..9 ]> <[ 0..9 ]>* /,
                     *.flip.comb( / <{ ". ** 1..3" }> / ).join( ',' ).flip;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $amount, $expected) = $line.split: / \| /;

        for     $test-name, $amount, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $count = count-ways-to-make-change( $amount.Int );

        is $count, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
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
        END
}

################################################################################
