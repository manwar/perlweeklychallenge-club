#!perl

################################################################################
=comment

Perl Weekly Challenge 375
=========================

TASK #1
-------
*Single Common Word*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings.

Write a script to return the number of strings that appear exactly once in each
of the two given arrays. String comparison is case sensitive.

Example 1

  Input: @array1 = ("apple", "banana", "cherry")
         @array2 = ("banana", "cherry", "date")
  Output: 2

Example 2

  Input: @array1 = ("a", "ab", "abc")
         @array2 = ("a", "a", "ab", "abc")
  Output: 2

  "a" appears once in @array1 but appears twice in @array2, therefore, not
  counted.

Example 3

  Input: @array1 = ("orange", "lemon")
         @array2 = ("grape", "melon")
  Output: 0

Example 4

  Input: @array1 = ("test", "test", "demo")
         @array2 = ("test", "demo", "demo")
  Output: 0

Example 5

  Input: @array1 = ("Hello", "world")
         @array2 = ("hello", "world")
  Output: 1

  String comparison is case sensitive.

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
2. Two strings are entered on the command-line. Each string contains a list of
   words separated by whitespace.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <array1> <array2>
  perl $0

    <array1>    A       whitespace-separated list of strings
    <array2>    Another whitespace-separated list of strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 375, Task #1: Single Common Word (Perl)\n\n";
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
        my ($array1, $array2) = @ARGV;
        my  @array1 = grep { length > 0 } split / \s+ /x, $array1;
        my  @array2 = grep { length > 0 } split / \s+ /x, $array2;

        printf "Input:  \@array1 = (%s)\n", join ', ', map { qq["$_"] } @array1;
        printf "        \@array2 = (%s)\n", join ', ', map { qq["$_"] } @array2;

        my $count = count_single_common_words( \@array1, \@array2 );

        print "Output: $count\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_single_common_words
#-------------------------------------------------------------------------------
{
    my ($array1, $array2) = @_;

    my  %dict1;
      ++$dict1{ $_ } for @$array1;

    my  %dict2;
      ++$dict2{ $_ } for @$array2;

    my  $count = 0;

    for my $key (keys %dict1)
    {
        ++$count if $dict1{ $key } == 1 && exists $dict2{ $key } &&
                    $dict2{ $key } == 1;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array1, $array2, $expected) = split / \| /x, $line;

        for ($test_name, $array1, $array2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array1 = grep { length > 0 } split / \s+ /x, $array1;
        my @array2 = grep { length > 0 } split / \s+ /x, $array2;
        my $count  = count_single_common_words( \@array1, \@array2 );

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
Example 1|apple banana cherry|banana cherry date|2
Example 2|a ab abc           |a a ab abc        |2
Example 3|orange lemon       |grape melon       |0
Example 4|test test demo     |test demo demo    |0
Example 5|Hello world        |hello world       |1
