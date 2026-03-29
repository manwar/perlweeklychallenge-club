#!perl

################################################################################
=comment

Perl Weekly Challenge 366
=========================

TASK #1
-------
*Count Prefixes*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a string (contains only lowercase English
letters).

Write a script to return the number of words in the given array that are a
prefix of the given string.

Example 1

  Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
  Output: 4

Example 2

  Input: @array = ("cat", "dog", "fish"), $str = "bird"
  Output: 0

Example 3

  Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
  Output: 4

Example 4

  Input: @array = ("", "code", "coding", "cod"), $str = "coding"
  Output: 3

Example 5

  Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"),
         $str = "program"
  Output: 7

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
2. A string of lowercase English letters is entered on the command-line, follow-
   ed by a list of words (also lowercase).

=cut
#===============================================================================

use v5.38.2;      # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert qq( on );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> [<array> ...]
  perl $0

    <str>            A string of lowercase English letters
    [<array> ...]    A list of words (also lowercase)
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 366, Task #1: Count Prefixes (Perl)\n\n";
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
        my  ($str, @array) = @ARGV;

        for ($str, @array)
        {
            is_lc( $_ ) or error( qq[The string "$_" is invalid] );
        }

        printf qq[Input:  \@array = (%s)\n], join ', ', map { qq["$_"] } @array;
        print  qq[        \$str   =  "$str"\n];

        my $count = count_prefixes( \@array, $str );

        print  "Output: $count\n";
    }
}

#-------------------------------------------------------------------------------
sub count_prefixes
#-------------------------------------------------------------------------------
{
    my ($array, $str) = @_;

    assert is_lc( $_ ) for @$array, $str;

    my  $count   = 0;
    my  $str_len = length $str;

    for my $word (@$array)
    {
        my $word_len = length $word;

        if ($word_len <= $str_len)
        {
            ++$count if substr( $str, 0, $word_len ) eq $word;
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub is_lc
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return $str =~ / ^ [a-z]* $ /x;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array_str, $str, $expected) = split / \| /x, $line;

        for ($test_name, $array_str, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array = split / \; \s+ /x, $array_str;
        my $count = count_prefixes( \@array, $str );

        is $count, $expected, $test_name;
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
Example 1|a; ap; app; apple; banana               |apple  |4
Example 2|cat; dog; fish                          |bird   |0
Example 3|hello; he; hell; heaven; he             |hello  |4
Example 4|; code; coding; cod                     |coding |3
Example 5|p; pr; pro; prog; progr; progra; program|program|7
