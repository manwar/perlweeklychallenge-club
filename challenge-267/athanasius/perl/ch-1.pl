#!perl

################################################################################
=comment

Perl Weekly Challenge 267
=========================

TASK #1
-------
*Product Sign*

Submitted by: Mohammad Sajid Anwar

You are given an array of @ints.

Write a script to find the sign of product of all integers in the given array.
The sign is 1 if the product is positive, -1 if the product is negative and 0 if
product is zero.

Example 1

  Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
  Output: 1

  The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

Example 2

  Input: @ints = (1, 2, 0, -2, -1)
  Output: 0

  The product 1 x 2 x 0 x -2 x -1 => 0

Example 3

  Input: @ints = (-1, -1, 1, -1, 2)
  Output: -1

  The product -1 x -1 x 1 x -1 x 2 => -2 < 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
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
    print "\nChallenge 267, Task #1: Product Sign (Perl)\n\n";
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

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $sign = find_product_sign( \@ints );

        print  "Output: $sign\n";
    }
}

#-------------------------------------------------------------------------------
sub find_product_sign
#-------------------------------------------------------------------------------
{
    my ($ints)     = @_;
    my  $neg_count = 0;

    for my $i (@$ints)
    {
        return 0     if $i == 0;
        ++$neg_count if $i <  0;
    }

    return $neg_count % 2 == 0 ? 1 : -1;
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

        my @ints = split / \s+ /x, $ints_str;
        my $sign = find_product_sign( \@ints );

        is $sign, $expected, $test_name;
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
Example 1|-1 -2 -3 -4  3  2  1| 1
Example 2| 1  2  0 -2 -1      | 0
Example 3|-1 -1  1 -1  2      |-1
