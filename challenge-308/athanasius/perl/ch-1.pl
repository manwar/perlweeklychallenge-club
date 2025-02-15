#!perl

################################################################################
=comment

Perl Weekly Challenge 308
=========================

TASK #1
-------
*Count Common*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.

Example 1

  Input: @str1 = ("perl", "weekly", "challenge")
         @str2 = ("raku", "weekly", "challenge")
  Output: 2

Example 2

  Input: @str1 = ("perl", "raku", "python")
         @str2 = ("python", "java")
  Output: 1

Example 3

  Input: @str1 = ("guest", "contribution")
         @str2 = ("fun", "weekly", "challenge")
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. String comparisons are case-sensitive.
2. If a string appears, say, twice in @str1 and three times in @str2, this adds
   only one to the count of strings common to both arrays.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string is a whitespace-
   separated list of words.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str1> <str2>
  perl $0

    <str1>    First  whitespace-separated list of words
    <str2>    Second whitespace-separated list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 308, Task #1: Count Common (Perl)\n\n";
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
        my ($str1, $str2) = @ARGV;
        my  @str1 = split / \s+ /x, $str1;
        my  @str2 = split / \s+ /x, $str2;

        printf "Input:  \@str1 = (%s)\n", join ', ', map { qq["$_"] } @str1;
        printf "        \@str2 = (%s)\n", join ', ', map { qq["$_"] } @str2;

        my $common = count_common( \@str1, \@str2 );

        print  "Output: $common\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_common
#-------------------------------------------------------------------------------
{
    my ($str1,  $str2) = @_;
    my (%dict1, %dict2);

    ++$dict1{ $_ } for @$str1;
    ++$dict2{ $_ } for @$str2;

    my $common = 0;

    exists $dict1{ $_ } and ++$common for keys %dict2;

    return $common;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @str1   = split / \s+ /x, $str1;
        my @str2   = split / \s+ /x, $str2;
        my $common = count_common( \@str1, \@str2 );

        is $common, $expected, $test_name;
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
Example 1|perl weekly challenge|raku weekly challenge     |2
Example 2|perl raku python     |python java               |1
Example 3|guest contribution   |fun weekly challenge      |0
Multiples|perl raku perl java  |perl fortran perl c++ perl|1
Case     |perl raku c++ java   |Perl Raku c++ Java        |1
