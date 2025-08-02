#!perl

################################################################################
=comment

Perl Weekly Challenge 288
=========================

TASK #1
-------
*Closest Palindrome*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself. If
there are more than one then return the smallest.

    The closest is defined as the absolute difference minimized between two
    integers.

Example 1

  Input: $str = "123"
  Output: "121"

Example 2

  Input: $str = "2"
  Output: "1"

  There are two closest palindrome "1" and "3". Therefore we return the smallest
  "1".

Example 3

  Input: $str = "1400"
  Output: "1441"

Example 4

  Input: $str = "1001"
  Output: "999"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input integer is unsigned (non-negative).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string representing an unsigned integer is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  Usage:
  perl $0 <str>
  perl $0

    <str>    A string representing an unsigned integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 288, Task #1: Closest Palindrome (Perl)\n\n";
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
        my $str =  $ARGV[ 0 ];
           $str =~ / ^ $RE{num}{int} $ /x
                     or error( qq["$str" is not a valid integer] );
           $str >= 0 or error( "$str is negative" );
           $str += 0;                                                # Normalize

        print qq[Input: \$str = "$str"\n];

        my $closest_palindrome = find_closest_palindrome( $str );

        print qq[Output:       "$closest_palindrome"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_closest_palindrome
#-------------------------------------------------------------------------------
{
    my ($int) = @_;

    return 1 if $int == 0;

    my $above = $int + 1;
     ++$above until is_palindrome( $above );

    my $below = $int - 1;
     --$below until is_palindrome( $below );

    my $above_diff = $above - $int;
    my $below_diff = $int - $below;

    return ($above_diff < $below_diff) ? $above : $below;
}

#-------------------------------------------------------------------------------
sub is_palindrome
#-------------------------------------------------------------------------------
{
    my ($int)   = @_;
    my  @digits = split //, $int;

    for my $i (0 .. int( $#digits / 2 ))
    {
        return 0 unless $digits[ $i ] == $digits[ $#digits - $i ];
    }

    return 1;
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

        my $closest_palindrome = find_closest_palindrome( $str );

        is $closest_palindrome, $expected, $test_name;
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
Example 1|    123|   121
Example 2|      2|     1
Example 3|   1400|  1441
Example 4|   1001|   999
Zero     |      0|     1
One      |      1|     0
1 Million|1000000|999999
Odd      |  12721| 12621
