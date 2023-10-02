#!perl

################################################################################
=comment

Perl Weekly Challenge 233
=========================

TASK #1
-------
*Similar Words*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabets only.

Write a script to find the number of pairs of similar words. Two words are
similar if they consist of the same characters.

Example 1

  Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
  Output: 2

  Pair 1: similar words ("aba", "aabb")
  Pair 2: similar words ("bac", "aabc")

Example 2

  Input: @words = ("aabb", "ab", "ba")
  Output: 3

  Pair 1: similar words ("aabb", "ab")
  Pair 2: similar words ("aabb", "ba")
  Pair 3: similar words ("ab", "ba")

Example 3

  Input: @words = ("nba", "cba", "dba")
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Identical strings in the input are treated as distinct for the enumeration of
   similar pairs. E.g., an input of "abc abc abc" should yield an output of 3.
2. Case is ignored for the purposes of comparison (i.e., for determining whether
   two words are "similar"), but retained in the enumeration of similar pairs.
   So, e.g., an input of "abc ABC BcA" should yield an output of 3:
       Pair 1: ("abc", "ABC")
       Pair 2: ("abc", "BcA")
       Pair 3: ("ABC", "BcA").

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output is followed by a
   list of the similar pairs found.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Tiny;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    A non-empty list of alphabetical-character words\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 233, Task #1: Similar Words (Perl)\n\n";
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
        my @words = @ARGV;

        / ^ [a-z]+ $ /ix or error( qq["$_" is not a valid word] )  for @words;

        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @words;
        
        my $pairs = find_pairs( \@words );
        my $count = scalar @$pairs;

        print "Output: $count\n";

        if ($VERBOSE && $count > 0)
        {
            print "\n";
            my $n = 1;

            for my $pair (@$pairs)
            {
                printf qq[Pair %d: similar words ("%s", "%s")\n], $n++, @$pair;
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub find_pairs
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  %dict;

    for my $word (@$words)
    {
        $dict{ $word } = Set::Tiny->new( split //, lc $word );
    }

    my @pairs;

    for my $i (0 .. $#$words - 1)
    {
        my $word1 = $words->[ $i ];

        for my $j ($i + 1 .. $#$words)
        {
            my $word2 = $words->[ $j ];

            push @pairs, [ $word1, $word2 ]
                if $dict{ $word1 }->is_equal( $dict{ $word2 } );
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $exp_str, @exp_pair_strs) =
             split / \| /x, $line;

        for ($test_name, $words_str, $exp_str, @exp_pair_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words = split / \s+ /x, $words_str;
        my @exp_pairs;

        for my $pair_str (@exp_pair_strs)
        {
            if (length $pair_str > 0)
            {
                push @exp_pairs, [ split / \s+ /x, $pair_str ];
            }
        }

        my $pairs = find_pairs( \@words );
        my $count = scalar @$pairs;

        is        $count,  $exp_str,   "$test_name: Count";
        is_deeply $pairs, \@exp_pairs, "$test_name: Pairs";
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
Example 1 |aba aabb abcd bac aabc|2|aba aabb|bac aabc
Example 2 |aabb ab ba            |3|aabb ab |aabb ba |ab ba
Example 3 |nba cba dba           |0|
Upper case|abc ABC aAbc          |3|abc ABC |abc aAbc|ABC aAbc
