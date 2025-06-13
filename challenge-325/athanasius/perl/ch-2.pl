#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Item prices are unsigned integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number  );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<prices> ...]
  perl $0

    [<prices> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 325, Task #2: Final Price (Perl)\n\n";
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
        my @prices = @ARGV;

        for (@prices)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is negative" );
        }

        printf "Input: \@prices = (%s)\n", join ', ', @prices;

        my $final_prices = find_final_prices( \@prices );

        printf "Output:          (%s)\n",  join ', ', @$final_prices;
    }
}

#-------------------------------------------------------------------------------
sub find_final_prices
#-------------------------------------------------------------------------------
{
    my ($prices) = @_;
    my  @final_prices;

    for my $i (0 .. $#$prices)
    {
        my $price_i = $prices->[ $i ];

        push @final_prices, $price_i;

        for my $j ($i + 1 .. $#$prices)
        {
            my $price_j = $prices->[ $j ];

            if ($price_j <= $price_i)
            {
                $final_prices[ $i ] -= $price_j;
                last;
            }
        }
    }

    return \@final_prices;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $prices_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $prices_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @prices       = split / \s+ /x, $prices_str;
        my $final_prices = find_final_prices( \@prices );
        my @expected     = split / \s+ /x, $expected_str;

        is_deeply $final_prices, \@expected, $test_name;
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
Example 1|8 4 6 2 3|4 2 4 2 3
Example 2|1 2 3 4 5|1 2 3 4 5
Example 3|7 1 1 5  |6 0 1 5
