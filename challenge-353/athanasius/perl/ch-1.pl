#!perl

################################################################################
=comment

Perl Weekly Challenge 353
=========================

TASK #1
-------
*Max Words*

Submitted by: Mohammad Sajid Anwar

You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single
sentence.

Example 1

  Input: @sentences = ("Hello world", "This is a test", "Perl is great")
  Output: 4

Example 2

  Input: @sentences = ("Single")
  Output: 1

Example 3

  Input: @sentences = ("Short", "This sentence has seven words in total",
                       "A B C", "Just four words here")
  Output: 7

Example 4

  Input: @sentences = ("One", "Two parts", "Three part phrase", "")
  Output: 3

Example 5

  Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A",
                       "She sells seashells by the seashore",
                       "To be or not to be that is the question")
  Output: 10

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Punctuation characters may, in general, be ignored, since they are counted as
   part of their adjacent words.
2. Apostrophes of possession may be similarly ignored since an expression like
   "Robert's book" is counted as 2 words.
3. The exceptions are dashes, which are not counted as words. They are handled
   as follows:
     i. Two or more hyphens together are considered a dash, whether or not they
        are surrounded by whitespace: "The problem--difficult though it may
        be--must be addressed" is counted as 10 words.
    ii. A single, detached hyphen is considered a dash: "Perl is useful - and
        fun!" is counted as 5 words.
   iii. All other hyphens are ignored. (This will sometimes produce incorrect
        results, since a compound phrase like "even-handed" should probably be
        counted as 2 words. However, distinguishing between "co-operate" [1
        word] and "heavy-metal" [2 words] would require recourse to a diction-
        ary, which is beyond the scope of this exercise.)

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of sentences is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;     # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<sentences> ...]
  perl $0

    [<sentences> ...]    A list of sentences
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 353, Task #1: Max Words (Perl)\n\n";
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
        my @sentences = @ARGV;

        printf "Input:  \@sentences = (%s)\n",
                join ', ', map { qq["$_"] } @sentences;

        my $max_words = count_max_words( \@sentences );

        print "Output: $max_words\n";
    }
}

#-------------------------------------------------------------------------------
sub count_max_words
#-------------------------------------------------------------------------------
{
    my ($sentences) = @_;
    my  $max_words  = 0;

    for my $sentence (@$sentences)
    {
        $sentence =~ s/     \- \-+     / /gx;          # Handle dashes
        $sentence =~ s/ \s+ \-     \s+ / /gx;

        my @words  = split / \s+ /x, $sentence;
        my $count  = scalar @words;
        $max_words = $count if $count > $max_words;
    }

    return $max_words;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chop $line;
            $line .= <DATA>;
        }

        my  ($test_name, $expected, @sentences) = split / \| /x, $line;

        for ($test_name, $expected, @sentences)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $max_words = count_max_words( \@sentences );

        is $max_words, $expected, $test_name;
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
Example 1  | 4|Hello world|This is a test|Perl is great
Example 2  | 1|Single
Example 3  | 7|Short|This sentence has seven words in total|A B C              \
              |Just four words here
Example 4  | 3|One|Two parts|Three part phrase|
Example 5  |10|The quick brown fox jumps over the lazy dog|A                   \
              |She sells seashells by the seashore                             \
              |To be or not to be that is the question
Dashes     |10|To be - or not to be--that is the question
Punctuation|10|To be, or not to be: is that the question?
