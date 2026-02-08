#!perl

################################################################################
=comment

Perl Weekly Challenge 359
=========================

TASK #2
-------
*String Reduction*

Submitted by: Mohammad Sajid Anwar

You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a
string until no adjacent duplicates remain and return the final word.

Example 1

  Input: $word = "aabbccdd"
  Output: ""

  Iteration 1: remove "aa", "bb", "cc", "dd" => ""

Example 2

  Input: $word = "abccba"
  Output: ""

  Iteration 1: remove "cc" => "abba"
  Iteration 2: remove "bb" => "aa"
  Iteration 3: remove "aa" => ""

Example 3

  Input: $word = "abcdef"
  Output: "abcdef"

  No duplicate found.

Example 4

  Input: $word = "aabbaeaccdd"
  Output: "aea"

  Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5

  Input: $word = "mississippi"
  Output: "m"

  Iteration 1: Remove "ss", "ss", "pp" => "miiii"
  Iteration 2: Remove "ii", "ii" => "m"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Characters are "duplicates" only if they have the same case; e.g., "aa" and "AA"
are adjacent duplicate characters, but "aA" and "Aa" are not.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string containing alphabetic characters only is entered on the command-
   line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my @ALPHABET => 'a' .. 'z';
const my $USAGE    => <<END;
Usage:
  perl $0 <word>
  perl $0

    <word>    A word composed of alphabetic characters only
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 359, Task #2: String Reduction (Perl)\n\n";
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
        my $word = $ARGV[0];
        my $re   = join '|', @ALPHABET;

        $word =~ / ^ (?:$re)* $ /ix
                 or error( qq["$word" contains non-alphabetic characters] );

        print qq[Input:  \$word = "$word"\n];

        my $reduced_str = reduce_string( $word );

        print qq[Output: "$reduced_str"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reduce_string
#-------------------------------------------------------------------------------
{
    my ($word) = @_;

    1 while $word =~ s/ (.) \1 //gx;

    return $word;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chop  $line;
            $line .= <DATA>;
            chomp $line;
        }

        my  ($test_name, $word, $expected) = split / \| /x, $line;

        for ($test_name, $word, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $reduced_str = reduce_string( $word );

        is $reduced_str, $expected, $test_name;
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
Example 1|aabbccdd   |
Example 2|abccba     |
Example 3|abcdef     |abcdef
Example 4|aabbaeaccdd|aea
Example 5|mississippi|m
