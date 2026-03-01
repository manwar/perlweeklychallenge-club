#!perl

################################################################################
=comment

Perl Weekly Challenge 362
=========================

TASK #1
-------
*Echo Chamber*

Submitted by: Mohammad Sajid Anwar

You are given a string containing lowercase letters.

Write a script to transform the string based on the index position of each
character (starting from 0). For each character at position i, repeat it i + 1
times.

Example 1

  Input: "abca"
  Output: "abbcccaaaa"

  Index 0: "a" -> repeated 1 time  -> "a"
  Index 1: "b" -> repeated 2 times -> "bb"
  Index 2: "c" -> repeated 3 times -> "ccc"
  Index 3: "a" -> repeated 4 times -> "aaaa"

Example 2

  Input: "xyz"
  Output: "xyyzzz"

  Index 0: "x" -> "x"
  Index 1: "y" -> "yy"
  Index 2: "z" -> "zzz"
  
Example 3

  Input: "code"
  Output: "coodddeeee"

  Index 0: "c" -> "c"
  Index 1: "o" -> "oo"
  Index 2: "d" -> "ddd"
  Index 3: "e" -> "eeee"

Example 4

  Input: "hello"
  Output: "heelllllllooooo"

  Index 0: "h" -> "h"
  Index 1: "e" -> "ee"
  Index 2: "l" -> "lll"
  Index 3: "l" -> "llll"
  Index 4: "o" -> "ooooo"

Example 5

  Input: "a"
  Output: "a"

  Index 0: "a" -> "a"

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
2. A single, non-empty string of lowercase letters is entered on the command-
   line.

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

    <str>    A string of lowercase letters
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 362, Task #1: Echo Chamber (Perl)\n\n";
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
           $str =~ / ^ [a-z]+ $ /x
                   or error( qq["$str" is not a valid input string] );

        print qq[Input:  "$str"\n];

        my $echoed_str = apply_echoes( $str );

        print qq[Output: "$echoed_str"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub apply_echoes
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @chars = split //, $str;
    my  $echoed_str;

    for my $i (0 .. $#chars)
    {
        $echoed_str .= $chars[$i] x ($i + 1);
    }

    return $echoed_str;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $string, $expected) = split / \| /x, $line;

        for ($test_name, $string, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $echoed_str = apply_echoes( $string );

        is $echoed_str, $expected, $test_name;
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
Example 1|abca |abbcccaaaa
Example 2|xyz  |xyyzzz
Example 3|code |coodddeeee
Example 4|hello|heelllllllooooo
Example 5|a    |a
