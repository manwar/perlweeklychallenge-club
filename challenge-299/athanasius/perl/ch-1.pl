#!perl

################################################################################
=comment

Perl Weekly Challenge 299
=========================

TASK #1
-------
*Replace Words*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a sentence.

Write a script to replace all words in the given sentence that start with any of
the words in the given array.

Example 1

  Input: @words = ("cat", "bat", "rat")
         $sentence = "the cattle was rattle by the battery"
  Output: "the cat was rat by the bat"

Example 2

  Input: @words = ("a", "b", "c")
         $sentence = "aab aac and cac bab"
  Output: "a a a c b"

Example 3

  Input: @words = ("man", "bike")
         $sentence = "the manager was hit by a biker"
  Output: "the man was hit by a bike"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line, followed by a list of words.

Assumptions
-----------
1. Matching is case-sensitive.
2. When words are replaced, punctuation should be retained.
3. If some of the given words are substrings of others, the shortest should be
   used as the replacement. For example, if the sentence is "I'm not ready for
   parenthood.", and the given words include both "parent" and "par", then re-
   placement should produce "I'm not ready for par."

=cut
#===============================================================================

use v5.32;      # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <sentence> [<words> ...]
  perl $0

    <sentence>        A sentence
    [<words> ...]     A list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 299, Task #1: Replace Words (Perl)\n\n";
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
        my $sentence = shift @ARGV;
        my @words    = @ARGV;

        printf qq[Input: \@words    = (%s)\n],
               join ', ', map { qq["$_"] } @words;

        print  qq[       \$sentence =  "$sentence"\n];

        my $new_sentence = replace_words( $sentence, \@words );

        print  qq[Output:             "$new_sentence"\n];
    }
}

#-------------------------------------------------------------------------------
sub replace_words
#-------------------------------------------------------------------------------
{
    my ($sentence, $words) = @_;

    for my $word (@$words)
    {
        $sentence =~ s/ \b $word [^.?!,;:" ]+ /$word/gx;
    }

    return $sentence;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $sentence) = split / \| /x, $line;
        my   $expected = <DATA>;

        for ($test_name, $words_str, $sentence, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words        = split / \s+ /x, $words_str;
        my $new_sentence = replace_words( $sentence, \@words );

        is $new_sentence, $expected, $test_name;
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
Example 1|cat bat rat|the cattle was rattle by the battery
                      the cat was rat by the bat
Example 2|a b c      |aab aac and cac bab
                      a a a c b
Example 3|man bike   |the manager was hit by a biker
                      the man was hit by a bike
Subset   |parent par |I'm not ready for parenthood
                      I'm not ready for par
