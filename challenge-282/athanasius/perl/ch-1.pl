#!perl

################################################################################
=comment

Perl Weekly Challenge 282
=========================

TASK #1
-------
*Good Integer*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int, having 3 or more digits.

Write a script to return the Good Integer in the given integer or -1 if none
found.

    A good integer is exactly three consecutive matching digits.

Example 1

  Input: $int = 12344456
  Output: "444"

Example 2

  Input: $int = 1233334
  Output: -1

Example 3

  Input: $int = 10020003
  Output: "000"

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
2. A positive integer of 3 or more digits is entered on the command-line.

Assumptions
-----------
1. Since the input integer must have at least 3 digits, and valid integers do
   not have leading zeros, the smallest valid input integer is 100.
2. A leading plus ("+") sign is also disallowed: only the digits 0-9 are accept-
   ed.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    A positive integer of 3 or more digits
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 282, Task #1: Good Integer (Perl)\n\n";
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
        my $int =  $ARGV[ 0 ];
           $int =~ / ^ [1-9] \d{2,} /x
                or error( qq["$int" is not a valid input integer] );

        print "Input: \$int = $int\n";

        my $good_int = find_good_integer( $int );

        print "Output: $good_int\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_good_integer
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  @runs = grep { length $_ == 3 } $int =~ / ( (\d) \2{2,} ) /gx;

    return scalar @runs ? qq["$runs[ 0 ]"] : -1;
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

        my $good_int = find_good_integer( $int );

        is $good_int, $expected, $test_name;
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
Example 1   |12344456          |"444"
Example 2   |1233334           |-1
Example 3   |10020003          |"000"
Multiple    |122234445666      |"222"
Initial     |9992555           |"999"
Final       |123776666888      |"888"
Final 4     |123456789999      |-1
All too long|111112222333334444|-1
Between 4s  |122223334444567   |"333"
