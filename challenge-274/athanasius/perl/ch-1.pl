#!perl

################################################################################
=comment

Perl Weekly Challenge 274
=========================

TASK #1
-------
*Goat Latin*

Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentance.

Write a script to convert the given sentence to Goat Latin, a made up language
similar to Pig Latin.

Rules for Goat Latin:

  1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
     "ma" to the end of the word.
  2) If a word begins with consonant i.e. not a vowel, remove first
     letter and append it to the end then add "ma".
  3) Add letter "a" to the end of first word in the sentence, "aa" to
     the second word, etc etc.

Example 1

  Input: $sentence = "I love Perl"
  Output: "Imaa ovelmaaa erlPmaaaa"

Example 2

  Input: $sentence = "Perl and Raku are friends"
  Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3

  Input: $sentence = "The Weekly Challenge"
  Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Within a series of "word" (alphabetic) characters, a hyphen is taken to be a
separator of distinct words.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input sentence is entered as an unnamed (positional) argument on the
   command-line.

=cut
#===============================================================================

use v5.32.1;      # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <sentence>
  perl $0

    <sentence>    A sentence to be translated into Goat Latin
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 274, Task #1: Goat Latin (Perl)\n\n";
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
        my $sentence = $ARGV[ 0 ];

        print qq[Input:  \$sentence = "$sentence"\n];

        my $translation = translate( $sentence );

        print qq[Output: "$translation"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub translate
#-------------------------------------------------------------------------------
{
    my ($sentence)   = @_;
    my  $translation = '';
    my  $count       =  1;

    for my $chunk (split / \b /x, $sentence)          # Split on word boundaries
    {
        if ($chunk =~ / \w /x)    # (1) The chunk is a word that...
        {
            if ($chunk =~ / ^ [aeiou] /ix)     # (1a) ...begins with a vowel
            {
                $translation .= $chunk;
            }
            else                               # (1b) ...begins with a consonant
            {
                $translation .= substr( $chunk, 1 ) . substr( $chunk, 0, 1 );
            }

            $translation .= 'ma' . 'a' x $count++;       # Append goatish suffix
        }
        else                      # (2) The chunk is space(s) and/or punctuation
        {
            $translation .= $chunk;
        }
    }

    return $translation;
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

            $line .= <DATA> =~ s/ ^ \s+ //rx;
        }

        my  ($test_name, $sentence, $expected) = split / \| /x, $line;

        for ($test_name, $sentence, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $translation = translate( $sentence );

        is $translation, $expected, $test_name;
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
Example 1|I love Perl              |Imaa ovelmaaa erlPmaaaa
Example 2|Perl and Raku are friends|erlPmaa andmaaa akuRmaaaa aremaaaaa \
                                    riendsfmaaaaaa
Example 3|The Weekly Challenge     |heTmaa eeklyWmaaa hallengeCmaaaa
