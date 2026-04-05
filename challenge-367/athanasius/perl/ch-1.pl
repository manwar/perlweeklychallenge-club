#!perl

################################################################################
=comment

Perl Weekly Challenge 367
=========================

TASK #1
-------
*Max Odd Binary*

Submitted by: Mohammad Sajid Anwar

You are given a binary string that has at least one '1'.

Write a script to rearrange the bits in such a way that the resulting binary
number is the maximum odd binary number and return the resulting binary string.
The resulting string can have leading zeros.

Example 1

  Input: $str = "1011"
  Output: "1101"

  "1101" is max odd binary (13).

Example 2

  Input: $str = "100"
  Output: "001"

  "001" is max odd binary (1).

Example 3

  Input: $str = "111000"
  Output: "110001"

Example 4

  Input: $str = "0101"
  Output: "1001"

Example 5

  Input: $str = "1111"
  Output: "1111"

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
2. A binary string, containing at least one "1", is entered on the command-line.

Algorithm
---------
The first 1 is placed as the least significant digit, any remaining 1s are
placed as the most significant digits.

=cut
#===============================================================================

use v5.38.2;      # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A binary string containing at least one "1"
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 367, Task #1: Max Odd Binary (Perl)\n\n";
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
        my $str =  $ARGV[0];
           $str =~ / ^ [01]* $ /x or error( qq["$str" is not a binary string] );
           $str =~ /     1     /x or error( qq["$str" has no '1' digits] );

        print qq[Input:  \$str = "$str"\n];

        my $max = find_max_odd_binary( $str );

        print qq[Output: "$max"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_max_odd_binary
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $ones = $str =~ tr/1//;
    my  $len  = length $str;

    return '1' x ($ones - 1) . '0' x ($len - $ones) . '1';
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $max = find_max_odd_binary( $str );

        is $max, $expected, $test_name;
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
Example 1|  1011|  1101
Example 2|   100|   001
Example 3|111000|110001
Example 4|  0101|  1001
Example 5|  1111|  1111
