#!perl

################################################################################
=comment

Perl Weekly Challenge 360
=========================

TASK #2
-------
*Word Sorter*

Submitted by: Mohammad Sajid Anwar

You are give a sentence.

Write a script to order words in the given sentence alphabetically but keeps the
words themselves unchanged.

Example 1

  Input: $str = "The quick brown fox"
  Output: "brown fox quick The"

Example 2

  Input: $str = "Hello    World!   How   are you?"
  Output: "are Hello How World! you?"

Example 3

  Input: $str = "Hello"
  Output: "Hello"

Example 4

  Input: $str = "Hello, World! How are you?"
  Output: "are Hello, How World! you?"

Example 5

  Input: $str = "I have 2 apples and 3 bananas!"
  Output: "2 3 and apples bananas! have I"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Sorting is ASCII-betical (digits before letters, see Example 5), but *case-
   insensitive*.
2. If two words differ only in the case of their letters, then their relative
   positions in the original sentence are retained in the output.
3. A punctuation character is, in general, treated as part of the word to which
   it is joined.
4. The exception is the dash, which is identified as either:
   - two or more contiguous hyphen-minus characters; or
   - a single hyphen-minus character surrounded on both sides by whitespace.
   Dashes are discarded, as they do not constitute "words".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line as a single string.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A sentence
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 360, Task #2: Word Sorter (Perl)\n\n";
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
        my $str = $ARGV[0];

        print qq[Input:  \$str = "$str"\n];

        my $ordered_str = sort_words( $str );

        print qq[Output: "$ordered_str"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub sort_words
#-------------------------------------------------------------------------------
{
    my ($str)     = @_;
    my  $sentence = $str =~ s/ \- \-    / /grx;
        $sentence =~        s/ \s \- \s / /gx;
    my  @words    = split / \s+ /x, $sentence;
        @words    = sort { lc( $a ) cmp lc( $b ) } @words;

    return join ' ', @words;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $ordered_str = sort_words( $str );

        is $ordered_str, $expected, $test_name;
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
Example 1|The quick brown fox             |brown fox quick The
Example 2|Hello    World!   How   are you?|are Hello How World! you?
Example 3|Hello                           |Hello
Example 4|Hello, World! How are you?      |are Hello, How World! you?
Example 5|I have 2 apples and 3 bananas!  |2 3 and apples bananas! have I
Dashes   |Hello - how are you--fine?      |are fine? Hello how you
