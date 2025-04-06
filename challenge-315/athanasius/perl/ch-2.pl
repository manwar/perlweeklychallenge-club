#!perl

################################################################################
=comment

Perl Weekly Challenge 315
=========================

TASK #2
-------
*Find Third*

Submitted by: Mohammad Sajid Anwar

You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in sequence
to the given two words.

Example 1

  Input: $sentence = "Perl is a my favourite language but Python is my favourite
                      too."
         $first = "my"
         $second = "favourite"
  Output: ("language", "too")

Example 2

  Input: $sentence = "Barbie is a beautiful doll also also a beautiful 
                      princess."
         $first = "a"
         $second = "beautiful"
  Output: ("doll", "princess")

Example 3

  Input: $sentence = "we will we will rock you rock you.",
         $first = "we"
         $second = "will"
  Output: ("we", "rock")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line, followed by two words.

Assumptions
-----------
1. Matches are case-sensitive, except in the following case: if the first match
   word begins with a lowercase letter, it matches the same word beginning with
   an uppercase letter if that word appears at the start of the sentence.
2. Punctuation characters are removed from the beginnings and endings of words,
   but not from within words. So, hyphenated words and possessives ending in
   "'s" remain unchanged.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <sentence> <first> <second>
  perl $0

    <sentence>    A sentence
    <first>       First  word
    <second>      Second word
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 315, Task #2: Find Third (Perl)\n\n";
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
    elsif ($argc == 3)
    {
        my ($sentence, $first, $second) = @ARGV;

        print qq[Input:  \$sentence = "$sentence"\n];
        print qq[        \$first    = "$first"\n];
        print qq[        \$second   = "$second"\n];

        my $third_words = find_third_words( $sentence, $first, $second );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$third_words;
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_third_words
#-------------------------------------------------------------------------------
{
    my ($sentence, $first, $second) = @_;

    # Split the sentence into words, but discard any "words" comprising only
    # punctuation, e.g. "--" or "***"

    my @words = grep { / [[:alnum:]] /x } split / \s+ /x, $sentence;

    for (@words) # Remove punctuation but leave internal hyphens and apostrophes
    {
        s/ \" //x;                    # Remove all double quotes
        s/ \' (\S+) /$1/x;            # Remove initial single quotes
        s/ [[:punct:]]+ $ //x;        # Remove all trailing punctuation
    }

    # Allow for a capital letter at the beginning of the sentence

    $words[ 0 ] =~ s/ ^ (.) /lc($1)/ex
        if scalar @words > 0 && $first =~ / ^ [[:lower:]] /x;

    my @third_words;

    for my $i (0 .. $#words - 2)
    {
        push @third_words, $words[ $i + 2 ] if $words[ $i     ] eq $first &&
                                               $words[ $i + 1 ] eq $second;
    }

    return \@third_words;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line1 = <DATA>)
    {
        my $line2 = <DATA>;

        chomp ($line1, $line2);

        my  ($test_name, $sentence)     = split / \| /x, $line1;
        my  ($first, $second, $exp_str) = split / \| /x, $line2;

        for ($test_name, $sentence, $first, $second, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $third_words = find_third_words( $sentence, $first, $second );
        my @expected    = split / \s+ /x, $exp_str;

        is_deeply $third_words, \@expected, $test_name;
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
Example 1 |Perl is a my favourite language but Python is my favourite too.
           my|favourite|language too
Example 2 |Barbie is a beautiful doll also also a beautiful princess
           a|beautiful|doll princess
Example 3 |we will we will rock you rock you.
           we|will|we rock
Case 1    |We will we will rock you rock you.
           we|will|we rock
Case 2    |Computers are fun, but computers are also a lot of work!
           computers|are|fun also
Hyphenated|My friend is hard-working, but your friend is lazy.
           friend|is|hard-working lazy
