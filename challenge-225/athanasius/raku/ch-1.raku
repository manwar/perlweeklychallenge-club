use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 225, Task #1: Max Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list where { .elems > 0 && .all ~~ Str:D }          #= A list of sentences
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf:
        @list.map( { qq["$_"] } ).join: ",\n" ~ ' ' x 17;

    my UInt $max-words = find-max-words( @list );

    "Output: $max-words".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-words( List:D[Str:D] $list --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-words = 0;

    for @$list -> Str $sentence
    {
        my Str @words = $sentence.split: / \s+ /, :skip-empty;

        $max-words = ($max-words, @words.elems).max;
    }

    return $max-words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $sentences, $expected) = $line.split: / \| /;

        for     $test-name, $sentences, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @sentences = $sentences.split: '\\';
        my UInt $max-words = find-max-words( @sentences );

        is $max-words, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $data = q:to/END/;
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
        END

    return S:g/ \s* \\ \n \s* /\\/ given $data;
}

################################################################################
