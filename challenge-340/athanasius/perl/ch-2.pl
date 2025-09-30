#!perl

################################################################################
=comment

Perl Weekly Challenge 340
=========================

TASK #2
-------
*Ascending Numbers*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, is a list of tokens separated by a single space.
Every token is either a positive number consisting of digits 0-9 with no leading
zeros, or a word consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly
increasing from left to right.

Example 1

  Input: $str = "The cat has 3 kittens 7 toys 10 beds"
  Output: true

  Numbers 3, 7, 10 - strictly increasing.

Example 2

  Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
  Output: false

Example 3

  Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
  Output: true

Example 4

  Input: $str = 'Bob has 10 cars 10 bikes'
  Output: false

Example 5

  Input: $str = 'Zero is 0 one is 1 two is 2'
  Output: true

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
2. A single string is entered on the command-line. The string comprises a space-
   separated list of words and numbers.

Notes
-----
1. The requirement that a word token "consist[s] of lowercase English letters"
   is contradicted by the first word in every Example. I have broadened the
   requirement to just "English letters" (of either case).
2. When an input token is found which does not match the requirements for either
   a number or a word, a warning is issued and the token is ignored.
   
=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string comprising a space-separated list of words and numbers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 340, Task #2: Ascending Numbers (Perl)\n\n";
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

        print  qq[Input:  \$str = "$str"\n];

        my $ascending = check_ascending( $str );

        printf "Output: %s\n", $ascending ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub check_ascending
#-------------------------------------------------------------------------------
{
    my ($str)     = @_;
    my  $last_num = -1;

    for my $token (split / \s+ /x, $str)
    {
        if    ($token =~ / ^ ( 0 | [1-9] \d* ) $ /x)
        {
            my $num = $1;

            return '' unless $num > $last_num;

            $last_num = $num;
        }
        elsif ($token !~ / ^ [A-Za-z]+ $ /x)
        {
            print qq[WARNING: Ignoring invalid token "$token"\n];
        }
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

        my $ascending = check_ascending( $str );
        my $asc_str   = $ascending ? 'true' : 'false';

        is $asc_str, $expected, $test_name;
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
Example 1|The cat has 3 kittens 7 toys 10 beds     |true
Example 2|Alice bought 5 apples 2 oranges 9 bananas|false
Example 3|I ran 1 mile 2 days 3 weeks 4 months     |true
Example 4|Bob has 10 cars 10 bikes                 |false
Example 5|Zero is 0 one is 1 two is 2              |true
