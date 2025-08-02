use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 325
=========================

TASK #2
-------
*Final Price*

Submitted by: Mohammad Sajid Anwar

You are given an array of item prices.

Write a script to find out the final price of each items in the given array.

There is a special discount scheme going on. If there’s an item with a lower or
equal price later in the list, you get a discount equal to that later price (the
first one you find in order).

Example 1

  Input: @prices = (8, 4, 6, 2, 3)
  Output: (4, 2, 4, 2, 3)

  Item 0:
  The item price is 8.
  The first time that has price <= current item price is 4.
  Final price = 8 - 4 => 4

  Item 1:
  The item price is 4.
  The first time that has price <= current item price is 2.
  Final price = 4 - 2 => 2

  Item 2:
  The item price is 6.
  The first time that has price <= current item price is 2.
  Final price = 6 - 2 => 4

  Item 3:
  The item price is 2.
  No item has price <= current item price, no discount.
  Final price = 2

  Item 4:
  The item price is 3.
  Since it is the last item, so no discount.
  Final price = 3

Example 2

  Input: @prices = (1, 2, 3, 4, 5)
  Output: (1, 2, 3, 4, 5)

Example 3

  Input: @prices = (7, 1, 1, 5)
  Output: (6, 0, 1, 5)

  Item 0:
  The item price is 7.
  The first time that has price <= current item price is 1.
  Final price = 7 - 1 => 6

  Item 1:
  The item price is 1.
  The first time that has price <= current item price is 1.
  Final price = 1 - 1 => 0

  Item 2:
  The item price is 1.
  No item has price <= current item price, so no discount.
  Final price = 1

  Item 3:
  The item price is 5.
  Since it is the last item, so no discount.
  Final price = 5

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Item prices are unsigned integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 325, Task #2: Final Price (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unsigned integers

    *@prices where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input: \@prices = (%s)\n".printf: @prices.join: ', ';

    my UInt @final-prices = find-final-prices( @prices );

    "Output:          (%s)\n".printf: @final-prices.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-final-prices( List:D[UInt:D] $prices --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @final-prices;

    for 0 .. $prices.end -> UInt $i
    {
        my UInt $price-i = $prices[ $i ];

        @final-prices.push: $price-i;

        for $i + 1 .. $prices.end -> UInt $j
        {
            my UInt $price-j = $prices[ $j ];

            if $price-j <= $price-i
            {
                @final-prices[ $i ] -= $price-j;
                last;
            }
        }
    }

    return @final-prices;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $prices-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $prices-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @prices       = $prices-str\ .split( / \s+ /, :skip-empty )
                                             .map: { .Int };
        my UInt @final-prices = find-final-prices( @prices );
        my UInt @expected     = $expected-str.split( / \s+ /, :skip-empty )
                                             .map: { .Int };

        is-deeply @final-prices, @expected, $test-name;
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
        Example 1|8 4 6 2 3|4 2 4 2 3
        Example 2|1 2 3 4 5|1 2 3 4 5
        Example 3|7 1 1 5  |6 0 1 5
        END
}

################################################################################
