#!perl

################################################################################
=comment

Perl Weekly Challenge 373
=========================

TASK #1
-------
*Equal List*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of strings.

Write a script to return true if the two given array represent the same strings
otherwise false.

Example 1

  Input: @arr1 = ("a", "bc")
         @arr2 = ("ab", "c")
  Output: true

  Array 1: "a" + "bc" = "abc"
  Array 2: "ab" + "c" = "abc"

Example 2

  Input: @arr1 = ("a", "b", "c")
         @arr2 = ("a", "bc")
  Output: true

  Array 1: "a" + "b" + "c" = "abc"
  Array 2: "a" + "bc" = "abc"

Example 3

  Input: @arr1 = ("a", "bc")
         @arr2 = ("a", "c", "b")
  Output: false

  Array 1: "a" + "bc" = "abc"
  Array 2: "a" + "c" + "b" = "acb"

Example 4

  Input: @arr1 = ("ab", "c", "")
         @arr2 = ("", "a", "bc")
  Output: true

  Array 1: "ab" + "c" + "" = "abc"
  Array 2: ""  + "a" + "bc" = "abc"

Example 5

  Input: @arr1 = ("p", "e", "r", "l")
         @arr2 = ("perl")
  Output: true

  Array 1: "p" + "e" + "r" + "l" = "perl"
  Array 2: "perl"

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
2. Two strings are entered on the command-line. Each comprises a list of strings
   (possibly empty) separated by pipe ("|") characters.

=cut
#===============================================================================

use v5.38.2;    # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <arr1> <arr2>
  perl $0

    <arr1>    A string comprising a pipe-separated list of strings
    <arr2>    A string comprising a pipe-separated list of strings
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 373, Task #1: Equal List (Perl)\n\n";
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
        # Note: The syntax for split() is:  split /PATTERN/,EXPR,LIMIT
        #       Setting LIMIT to -1 overrides the normal behaviour, which is to
        #       strip trailing empty fields

        my @arr1 = split / \| /x, $ARGV[0], -1;
        my @arr2 = split / \| /x, $ARGV[1], -1;

        printf qq[Input:  \@arr1 = (%s)\n], join ', ', map { qq["$_"] } @arr1;
        printf qq[        \@arr2 = (%s)\n], join ', ', map { qq["$_"] } @arr2;

        my $equal = lists_are_equal( \@arr1, \@arr2 );

        printf qq[Output: %s\n], $equal ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub lists_are_equal
#-------------------------------------------------------------------------------
{
    my ($arr1, $arr2) = @_;

    my  $str1 = join '', @$arr1;
    my  $str2 = join '', @$arr2;

    return $str1 eq $str2;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $arr1, $arr2, $expected) = split / \| /x, $line;

        $test_name =~ s/ \s+ $ //x;

        my @arr1  = split / \: /x, $arr1, -1;
        my @arr2  = split / \: /x, $arr2, -1;
        my $equal = lists_are_equal( \@arr1, \@arr2 ) ? 'true' : 'false';

        is $equal, $expected, $test_name;
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
Example 1|a:bc|ab:c|true
Example 2|a:b:c|a:bc|true
Example 3|a:bc|a:c:b|false
Example 4|ab:c:|:a:bc|true
Example 5|p:e:r:l|perl|true
