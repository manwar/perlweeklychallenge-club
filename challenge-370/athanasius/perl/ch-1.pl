#!perl

################################################################################
=comment

Perl Weekly Challenge 370
=========================

TASK #1
-------
*Popular Word*

Submitted by: Mohammad Sajid Anwar

You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It is guaran-
teed there is at least one word that is not banned and the answer is unique. The
words in paragraph are case-insensitive and the answer should be in lowercase.
The words can not contain punctuation symbols.

Example 1

  Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
         @banned = ("hit")
  Output: "ball"

  After removing punctuation and converting to lowercase, the word "hit" appears
  3 times, and "ball" appears 2 times.
  Since "hit" is on the banned list, we ignore it.

Example 2

  Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
         @banned = ("apple", "pear")
  Output: "orange"

  "apple"  appears 4 times.
  "pear"   appears 2 times.
  "orange" appears 2 times.

  "apple" and "pear" are both banned.
  Even though "orange" has the same frequency as "pear", it is the only non-
  banned word with the highest frequency.

Example 3

  Input: $paragraph = "A. a, a! A. B. b. b."
         @banned = ("b")
  Output: "a"

  "a" appears 4 times.
  "b" appears 3 times.

  The input has mixed casing and heavy punctuation.
  The normalised, "a" is the clear winner, since "b" is banned, "a" is the only
  choice.

Example 4

  Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
         @banned = ("ball")
  Output: "apple"

  Here the punctuation acts as a delimiter.
  "ball"   appears 3 times.
  "apple"  appears 2 times.
  "banana" appears 1 time.

Example 5

  Input: $paragraph = "The dog chased the cat, but the dog was faster than the
                       cat."
         @banned = ("the", "dog")
  Output: "cat"

  "the" appears 4 times.
  "dog" appears 2 times.
  "cat" appears 2 times.

  "chased", "but", "was", "faster", "than" appear 1 time each.
  "the" is the most frequent but is banned.
  "dog" is the next most frequent but is also banned.
  The next most frequent non-banned word is "cat".

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. If a paragraph word is hyphenated, it is treated as two separate words. For
   example, "co-exist" is treated as "co" and "exist".
2. If a banned word contains uppercase letters, they are converted to lowercase.
3. If a banned word contains non-alphabetic characters, they are removed (other-
   wise it would have no effect, since paragraph words cannot contain non-alpha-
   betic characters and so could never match).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A paragraph string is entered on the command-line, followed by a list of
   banned words.

=cut
#===============================================================================

use v5.38.2;   # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( max none );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <paragraph> [<banned> ...]
  perl $0

    <paragraph>       A string paragraph
    [<banned> ...]    A list of banned words
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 370, Task #1: Popular Word (Perl)\n\n";
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
        my ($paragraph, @banned) = @ARGV;

        print  qq[Input:  \$paragraph =  "$paragraph"\n];
        printf qq[        \@banned    = (%s)\n],
               join ', ', map { qq["$_"] } @banned;

        my $popular = find_popular_word( $paragraph, \@banned );

        printf "Output: %s\n", defined $popular ? qq["$popular"] : '<none>';
    }
}

#-------------------------------------------------------------------------------
sub find_popular_word
#-------------------------------------------------------------------------------
{
    my ($paragraph, $banned) = @_;
    my  @words  = split / [^A-Za-z]+ /x, $paragraph; 
        @words  = map { lc $_ } @words;
    my  @banned = map { lc $_ } @$banned;
    my (%dict, $popular);

    s/ [^A-Za-z] //gx for @banned;

    for my $word (@words)
    {
        ++$dict{$word} if none { $word eq $_ } @banned;
    }

    if (scalar keys %dict > 0)
    {
        my $max_freq     = max values %dict;
        my @most_popular = grep { $dict{$_} == $max_freq } keys %dict;

        # "It is guaranteed there is at least one word that is not banned and
        #  the answer is unique."

        $popular = $most_popular[0] if scalar @most_popular == 1;
    }

    return $popular;
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

        my  ($test_name, $paragraph, $banned_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $paragraph, $banned_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @banned  = grep { / \S /x } split / \s+ /x, $banned_str;
        my $popular = find_popular_word( $paragraph, \@banned ) // '<none>';

        is $popular, $expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1 |Bob hit a ball, the hit BALL flew far after it was hit.|hit|ball
Example 2 |Apple? apple! Apple, pear, orange, pear, apple, orange.|apple pear  \
          |orange
Example 3 |A. a, a! A. B. b. b.|b|a
Example 4 |Ball.ball,ball:apple!apple.banana|ball|apple
Example 5 |The dog chased the cat, but the dog was faster than the cat.|the dog\
          |cat
All banned|The DOG chased the cat, the bird watched.|bird but cat chased dog   \
           the watched|<none>
Not unique|Perl Raku C||<none>
