#!perl

################################################################################
=comment

Perl Weekly Challenge 392
=========================

TASK #1
-------
*Convert Palindrome*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to convert the given string to palindrome by adding characters in
front of it.

Example 1

  Input: $str = "pinnipeds"
  Output: "sdepinnipeds"

Example 2

  Input: $str = "abcd"
  Output: "dcbabcd"

Example 3

  Input: $str = "bananas"
  Output: "sananabananas"

Example 4

  Input: $str = "dissident"
  Output: "tnedissident"

Example 5

  Input: $str = "cailliachs"
  Output: "shcailliachs"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. If the input string is already a palindrome, no conversion is needed.
2. The empty string is a palindrome.
3. A string of one character is a palindrome.
4. If the input string is not a palindrome, it is to be converted into a palin-
   drome by prepending the *minimum* number of additional characters.
5. Comparison of characters is case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. Otherwise, a single string is entered on the command-line.
3. If the constant $DEBUG is set to a true value, the conversion result is
   double-checked to ensure that it is a palindrome.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Test::More;

const my $DEBUG => true;
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
    print "\nChallenge 392, Task #1: Convert Palindrome (Perl)\n\n";
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

        my $palindrome = convert_palindrome( $str );

        print qq[Output: "$palindrome"\n];
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub convert_palindrome
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $palindrome;

    if    (is_palindrome( $str ))
    {
        $palindrome = $str;
    }
    elsif ($str =~ / ^ (.+) .? (??{ reverse $1 }) (.*) $ /x)
    {
        $palindrome = reverse( $2 ) . $str;
    }
    else
    {
        $str =~ / ^ . (.+) $ /x;

        $palindrome = reverse( $1 ) . $str;
    }

    is_palindrome( $palindrome ) or die qq["$palindrome" is not a palindrome]
        if $DEBUG;

    return $palindrome;
}

#-------------------------------------------------------------------------------
sub is_palindrome
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $len  = length $str;

    if ($len > 1)
    {
        for my $i (0 .. int( $len / 2 - 1 ))
        {
            my $j = $len - $i - 1;

            return false unless substr( $str, $i, 1 ) eq
                                substr( $str, $j, 1 );
        }
    }

    return true;
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

        my $palindrome = convert_palindrome( $str );

        is $palindrome, $expected, $test_name;
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
Example 1   |pinnipeds                |sdepinnipeds
Example 2   |abcd                     |dcbabcd
Example 3   |bananas                  |sananabananas
Example 4   |dissident                |tnedissident
Example 5   |cailliachs               |shcailliachs
Empty string|                         |
Single char |X                        |X
Palindrome  |able was I ere I saw elba|able was I ere I saw elba
