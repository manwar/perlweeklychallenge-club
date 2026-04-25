#!perl

################################################################################
=comment

Perl Weekly Challenge 370
=========================

TASK #2
-------
*Scramble String*

Submitted by: Roger Bell_West

You are given two strings A and B of the same length.

Write a script to return true if string B is a scramble of string A otherwise
return false.

String B is a scramble of string A if A can be transformed into B by a single
(recursive) scramble operation.

A scramble operation is:

  - If the string consists of only one character, return the string.
  - Divide the string X into two non-empty parts.
  - Optionally, exchange the order of those parts.
  - Optionally, scramble each of those parts.
  - Concatenate the scrambled parts to return a single string.

Example 1

  Input: $str1 = "abc", $str2 = "acb"
  Output: true

  "abc"
  split: ["a", "bc"]
  split: ["a", ["b", "c"]]
  swap: ["a", ["c", "b"]]
  concatenate: "acb"

Example 2

  Input: $str1 = "abcd", $str2 = "cdba"
  Output: true

  "abcd"
  split: ["ab", "cd"]
  swap: ["cd", "ab"]
  split: ["cd", ["a", "b"]]
  swap: ["cd", ["b", "a"]]
  concatenate: "cdba"

Example 3

  Input: $str1 = "hello", $str2 = "hiiii"
  Output: false

  A fundamental rule of scrambled strings is that they must be anagrams.

Example 4

  Input: $str1 = "ateer", $str2 = "eater"
  Output: true

  "ateer"
  split: ["ate", "er"]
  split: [["at", "e"], "er"]
  swap: [["e", "at"], "er"]
  concatenate: "eater"

Example 5

  Input: $str1 = "abcd", $str2 = "bdac"
  Output: false

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
2. Two strings of the same length are entered on the command-line.

Assumption
----------
Two identical strings are scrambles of each other (the degenerate case).

=cut
#===============================================================================

use v5.38.2;    # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Set::Tiny;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str1> <str2>
  perl $0

    <str1>    A string
    <str2>    Another string of the same length
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 370, Task #2: Scramble String (Perl)\n\n";
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

        length $str1 == length $str2
            or error( qq["$str1" and "$str2" have different lengths] );

        print  qq[Input:  \$str1 = "$str1", \$str2 = "$str2"\n];

        my $are_scrambles = are_scrambles( $str1, $str2 );

        printf qq[Output: %s\n], $are_scrambles ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub are_scrambles
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;

    length $str1 == length $str2
        or die qq["$str1" and "$str2" have different lengths, stopped];

    return true if $str1 eq $str2;                        # See Assumption above

    if (are_anagrams( $str1, $str2 ))                     # See Example 3
    {
        for my $scramble (scramble( $str1 )->@*)
        {
            return true if $scramble eq $str2;
        }
    }

    return false;
}

#-------------------------------------------------------------------------------
sub scramble
#-------------------------------------------------------------------------------
{
    my ($str)      = @_;
    my  $scrambles = Set::Tiny->new;

    if (length $str > 1)
    {
        for my $i (1 .. length( $str ) - 1)                  # Divide the string
        {
            my $left_str  = substr $str, 0, $i;
            my $right_str = substr $str, $i;
                                                              # Recursive calls:
            for my $left ($left_str, scramble( $left_str )->@*)            # (1)
            {
                for my $right ($right_str, scramble( $right_str )->@*)     # (2)
                {
                    # Concatenate, with and without reversal

                    $scrambles->insert( "$left$right", "$right$left" );
                }
            }
        }
    }
    else
    {
        $scrambles->insert( $str );                                  # Base case
    }

    return [ $scrambles->elements ];
}

#-------------------------------------------------------------------------------
sub are_anagrams
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;
    my  $str1_ordered = join '', sort split //, $str1;
    my  $str2_ordered = join '', sort split //, $str2;

    return $str1_ordered eq $str2_ordered;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $are_scrambles = are_scrambles( $str1, $str2 ) ? 'true' : 'false';

        is $are_scrambles, $expected, $test_name;
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

# It is assumed that *test* data strings do not begin or end with whitespace

__DATA__
Example 1|abc  |acb  |true
Example 2|abcd |cdba |true
Example 3|hello|hiiii|false
Example 4|ateer|eater|true
Example 5|abcd |bdac |false
Identical|abcde|abcde|true
