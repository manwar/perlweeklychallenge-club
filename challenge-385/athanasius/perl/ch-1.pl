#!perl

################################################################################
=comment

Perl Weekly Challenge 385
=========================

TASK #1
-------
*Uncommon Words*

Submitted by: Mohammad Sajid Anwar

You are given two sentences.

Write a script to return list of all uncommon words, order is not important.

Example 1

  Input: $sentence1 = "apple banana apple"
         $sentence2 = "banana orange"
  Output: ("orange")

Example 2

  Input: $sentence1 = "cat dog"
         $sentence2 = "bird fish"
  Output: ("cat", "dog", "bird", "fish")

Example 3

  Input: $sentence1 = "the quick brown fox"
         $sentence2 = "the quick"
  Output: ("brown", "fox")

Example 4

  Input: $sentence1 = "hello"
         $sentence2 = "hello"
  Output: ()

Example 5

  Input: $sentence1 = "blue blue red"
         $sentence2 = "red green green yellow"
  Output: ("yellow")

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
2. Two sentences are entered on the command-line.

Assumption
----------
Comparisons are case-sensitive.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <sentence1> <sentence2>
  perl $0

    <sentence1>    First  sentence
    <sentence2>    Second sentence
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 385, Task #1: Uncommon Words (Perl)\n\n";
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
        my  ($sentence1, $sentence2) = @ARGV;

        print  qq[Input:  \$sentence1 = "$sentence1"\n];
        print  qq[        \$sentence2 = "$sentence2"\n];

        my $uncommon_words = find_uncommon_words( $sentence1, $sentence2 );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$uncommon_words;
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_uncommon_words
#-------------------------------------------------------------------------------
{
    my ($sentence1, $sentence2) = @_;

    my   @words = split / \s+ /x, $sentence1;
    push @words,  split / \s+ /x, $sentence2;
    my   %word_count;

       ++$word_count{ $_ } for @words;

    return [ sort grep { $word_count{ $_ } == 1 } keys %word_count ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $sentence1, $sentence2, @expected) =
             split / \| /x, $line;

        for ($test_name, $sentence1, $sentence2, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $uncommon_words = find_uncommon_words( $sentence1, $sentence2 );

        is_deeply $uncommon_words, \@expected, $test_name;
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
Example 1|apple banana apple |banana orange         |orange
Example 2|cat dog            |bird fish             |bird |cat|dog|fish
Example 3|the quick brown fox|the quick             |brown|fox
Example 4|hello              |hello
Example 5|blue blue red      |red green green yellow|yellow
