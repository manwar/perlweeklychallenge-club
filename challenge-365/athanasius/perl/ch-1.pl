#!perl

################################################################################
=comment

Perl Weekly Challenge 365
=========================

TASK #1
-------
*Alphabet Index Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given a string $str consisting of lowercase English letters, and an
integer $k.

Write a script to convert a lowercase string into numbers using alphabet
positions (a=1 … z=26), concatenate them to form an integer, then compute the
sum of its digits repeatedly $k times, returning the final value.

Example 1

  Input: $str = "abc", $k = 1
  Output: 6

  Conversion: a = 1, b = 2, c = 3 -> 123
  Digit sum: 1 + 2 + 3 = 6

Example 2

  Input: $str = "az", $k = 2
  Output: 9

  Conversion: a = 1, z = 26 -> 126
  1st sum: 1 + 2 + 6 = 9
  2nd sum: 9

Example 3

  Input: $str = "cat", $k = 1
  Output: 6

  Conversion: c = 3, a = 1, t = 20 -> 3120
  Digit sum: 3 + 1 + 2 + 0 = 6

Example 4

  Input: $str = "dog", $k = 2
  Output: 8

  Conversion: d = 4, o = 15, g = 7 -> 4157
  1st sum: 4 + 1 + 5 + 7 = 17
  2nd sum: 1 + 7 = 8

Example 5

  Input: $str = "perl", $k = 3
  Output: 6

  Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
  1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
  2nd sum: 2+4 = 6
  3rd sum: 6

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. $k is a positive (i.e., unsigned) integer.
2. If $k = 0 then the concatenated digits are not summed at all.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of lowercase English letters is entered on the command-line, follow-
   ed by a non-zero positive integer.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string composed of digits and the hash character
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 365, Task #1: Alphabet Index Digit Sum (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($str, $k) =  @ARGV;

        $str =~ / ^ [a-z]* $ /x
                  or error( qq["$str" is not a valid input string] );

        $k   =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$k" is not a valid integer] );

        $k   >= 0 or error( "$k is negative" );

        print qq[Input:  \$str = "$str", \$k = $k\n];

        my $sum = find_digit_sum( $str, $k );

        print "Output: $sum\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_digit_sum
#-------------------------------------------------------------------------------
{
    my ($str, $k) = @_;

    assert $str =~ / ^ [a-z]* $ /x && $k =~ / ^ $RE{num}{int} $ /x && $k >= 0;

    my $int = '';

    for my $chr (split //, $str)
    {
        $int .= ord( $chr ) - ord( 'a' ) + 1;
    }

    until ($k-- <= 0 || length $int == 1)
    {
        my $sum  = 0;
           $sum += $_ for split //, $int;
           $int  = $sum;
    }

    return $int;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $k, $expected) = split / \| /x, $line;

        for ($test_name, $str, $k, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $sum = find_digit_sum( $str, $k );

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
Example 1|abc        |1|          6
Example 2|az         |2|          9
Example 3|cat        |1|          6
Example 4|dog        |2|          8
Example 5|perl       |3|          6
Big sum 0|iiiiiiiiiii|0|99999999999
Big sum 1|iiiiiiiiiii|1|         99
Big sum 2|iiiiiiiiiii|2|         18
Big sum 5|iiiiiiiiiii|5|          9
