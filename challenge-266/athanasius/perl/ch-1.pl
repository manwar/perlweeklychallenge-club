#!perl

################################################################################
=comment

Perl Weekly Challenge 266
=========================

TASK #1
-------
*Uncommon Words*

Submitted by: Mohammad Sajid Anwar

You are given two sentences, $line1 and $line2.

Write a script to find all uncommmon words in any order in the given two sen-
tences. Return ('') if none found.

    A word is uncommon if it appears exactly once in one of the sentences and
    doesn't appear in other sentence.

Example 1

  Input: $line1 = 'Mango is sweet'
         $line2 = 'Mango is sour'
  Output: ('sweet', 'sour')

Example 2

  Input: $line1 = 'Mango Mango'
         $line2 = 'Orange'
  Output: ('Orange')

Example 3

  Input: $line1 = 'Mango is Mango'
         $line2 = 'Orange is Orange'
  Output: ('')

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Word-matching within and between sentences is case-insensitive.
2. Singular and plural forms are treated as distinct words.
3. Two or more hyphens together are treated as a word-separating dash.
4. A single hyphen is assumed to be "hard" and is retained within a word.
5. The possessive forms ending in "'s" or "'" are ignored when matching words.
6. Other punctuation symbols (commas, full stops, colons, semicolons, question
   marks, exclamation marks, single quotes, and double quotes) are treated as
   word-separators but otherwise ignored.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input sentences are entered as two strings on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <line1> <line2>
  perl $0

    <line1>    The first  sentence
    <line2>    The second sentence
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 266, Task #1: Uncommon Words (Perl)\n\n";
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
        my ($line1, $line2) = @ARGV;

        print "Input:  \$line1 = '$line1'\n";
        print "        \$line2 = '$line2'\n";

        my $uncommon_words = find_uncommon_words( $line1, $line2 );

        printf "Output: (%s)\n", scalar @$uncommon_words == 0 ? "''" :
                                     join ', ', map { "'$_'" } @$uncommon_words;
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_uncommon_words
#-------------------------------------------------------------------------------
{
    my ($line1, $line2) = @_;

    my   @words = filter_words( $line1 );
    push @words,  filter_words( $line2 );

    my %dict;
     ++$dict{ $_ } for map { lc() } @words;

    my @uncommon;

    for my $word (@words)
    {
        push @uncommon, $word if $dict{ lc $word } == 1;
    }

    return \@uncommon;
}

#-------------------------------------------------------------------------------
sub filter_words
#-------------------------------------------------------------------------------
{
    my ($line) = @_;

    $line =~ s{ \-{2,}        }{ }gx;            # Convert dashes to spaces
    $line =~ s{ (?<= \w) \' s? }{}gx;            # Remove possessive markers
    $line =~ s{ [.,;:!?'"]    }{ }gx;            # Convert punctuation to spaces

    return grep { / \S /x } split / \s+ /x, $line;      # Find (non-empty) words
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $line1, $line2, $expected_str) = split / \| /x, $line;

        for ($test_name, $line1, $line2, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $uncommon_words = find_uncommon_words( $line1, $line2 );
        my @expected_words = split / \s+ /x, $expected_str;

        is_deeply $uncommon_words, \@expected_words, $test_name;
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
Example 1  |Mango is sweet       |Mango is sour        |sweet sour
Example 2  |Mango Mango          |Orange               |Orange
Example 3  |Mango is Mango       |Orange is Orange     |
Case       |The cat is on the mat|A dog is on a log    |cat mat dog log
Plurals    |This dog likes dogs  |This dog likes cats  |dogs cats
Possessives|Pete is my son's son |Pete is my grandson  |grandson
Dash       |Sue--my favourite.   |Is Sue my favourite? |Is
Hyphen     |Implement: egg-beater|Egg implement        |egg-beater Egg
Punctuation|Sue has a book.      |Does Sue have a book?|has Does have
Quotes     |"Mango" is sweet     |Mango is 'sour'      |sweet sour
