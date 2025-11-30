#!perl

################################################################################
=comment

Perl Weekly Challenge 349
=========================

TASK #1
-------
*Power String*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the power of the given string.

    The power of the string is the maximum length of a non-empty substring that
    contains only one unique character.

Example 1

  Input: $str = "textbook"
  Output: 2

  Breakdown: "t", "e", "x", "b", "oo", "k"
  The longest substring with one unique character is "oo".

Example 2

  Input: $str = "aaaaa"
  Output: 5

Example 3

  Input: $str = "hoorayyy"
  Output: 3

  Breakdown: "h", "oo", "r", "a", "yyy"
  The longest substring with one unique character is "yyy".

Example 4

  Input: $str = "x"
  Output: 1

Example 5

  Input: $str = "aabcccddeeffffghijjk"
  Output: 4

  Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
  The longest substring with one unique character is "ffff".

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;   # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( max );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 349, Task #1: Power String (Perl)\n\n";
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
        my $str = $ARGV[0];

        print qq[Input:  \$str = "$str"\n];

        my $power = find_power( $str );

        print "Output: $power\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_power
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  $power = 0;
        $power = max( $power, length $1 ) while $str =~ / ( (.) \2* ) /gx;

    return $power;
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

        my $power = find_power( $str );

        is $power, $expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1|textbook            |2
Example 2|aaaaa               |5
Example 3|hoorayyy            |3
Example 4|x                   |1
Example 5|aabcccddeeffffghijjk|4
Empty    |                    |0
