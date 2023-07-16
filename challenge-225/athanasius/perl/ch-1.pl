#!perl

################################################################################
=comment

Perl Weekly Challenge 225
=========================

TASK #1
-------
*Max Words*

Submitted by: Mohammad S Anwar

You are given a list of sentences, @list.

    A sentence is a list of words that are separated by a single space with no
    leading or trailing spaces.

Write a script to find out the maximum number of words that appear in a single
sentence.

Example 1

  Input: @list = ("Perl and Raku belong to the same family.",
                  "I love Perl.",
                  "The Perl and Raku Conference.")
  Output: 8

Example 2

  Input: @list = ("The Weekly Challenge.",
                  "Python is the most popular guest language.",
                  "Team PWC has over 300 members.")
  Output: 7

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <list>
  perl $0

    <list>    A list of sentences\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 225, Task #1: Max Words (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if ($args == 0)
    {
        run_tests();
    }
    else
    {
        my @list = @ARGV;

        printf "Input:  \@list = (%s)\n",
                join ",\n" . ' ' x 17, map { qq["$_"] } @list;

        my $max_words = find_max_words( \@list );

        print "Output: $max_words\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_words
#-------------------------------------------------------------------------------
{
    my ($list)     = @_;
    my  $max_words = 0;

    for my $sentence (@$list)
    {
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
        $line .= <DATA> while $line =~ / \\ $ /x;

        my  ($test_name, $sentences, $expected) = split / \| /x, $line;

        for ($test_name, $sentences, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my   @sentences = split / \\ /x, $sentences;

        for (@sentences)
        {
            s/ ^ \s*   //x;
            s/   \s* $ //x;
        }

        my $max_words = find_max_words( \@sentences );

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
Example 1   |Perl and Raku belong to the same family.                  \
             I love Perl.                                              \
             The Perl and Raku Conference.                           | 8
Example 2   |The Weekly Challenge.                                     \
             Python is the most popular guest language.                \
             Team PWC has over 300 members.                          | 7
Long & short|Did Peter Piper pick a peck of pickled peppers?           \
             She said, "Supercalifragilisticexpialidocious!"           \
             Listen!                                                   \
             Yes! Peter Piper did pick a peck of pickled peppers.      \
             I tawt I taw a puddy tat; I did, I did taw a puddy tat! |15
