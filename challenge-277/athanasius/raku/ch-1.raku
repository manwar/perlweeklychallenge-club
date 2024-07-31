use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 277
=========================

TASK #1
-------
*Count Common*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @words1 and @words2.

Write a script to return the count of words that appears in both arrays exactly
once.

Example 1

  Input: @words1 = ("Perl", "is", "my", "friend")
         @words2 = ("Perl", "and", "Raku", "are", "friend")
  Output: 2

  The words "Perl" and "friend" appear once in each array.

Example 2

  Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
         @words2 = ("Python", "is", "top", "in", "guest", "languages")
  Output: 1

Example 3

  Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
         @words2 = ("Crystal", "is", "similar", "to", "Ruby")
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Only words matching exactly (including case) are considered "the same". For
   example, "Perl" and "perl" are treated as different words, as are "friend"
   and "friends".
2. Within the input strings, words are separated by whitespace only. Any punctu-
   ation characters are treated as part of the words.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input word lists are entered as two strings. Within each string, words
   are separated by whitespace.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 277, Task #1: Count Common (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D   $words1-str,               #= String 1 of whitespace-separated words
    Str:D   $words2-str,               #= String 2 of whitespace-separated words
    Bool:D :$verbose = False           #= Explain the output?
)
#===============================================================================
{
    my Str @words1 = $words1-str.split: / \s+ /, :skip-empty;
    my Str @words2 = $words2-str.split: / \s+ /, :skip-empty;

    "Input:  \@words1 = (%s)\n".printf:  @words1.map( { qq["$_"] } ).join: ', ';
    "        \@words2 = (%s)\n".printf:  @words2.map( { qq["$_"] } ).join: ', ';

    my Str  @common = find-common-words( @words1, @words2 );
    my UInt $count  = @common.elems;

    "Output: $count".put;

    if $verbose && $count > 0
    {
        "\nWord%s appearing exactly once in each array: %s\n".printf:
             ($count == 1 ?? '' !! 's'), @common.map( { qq["$_"] } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-common-words
(
    List:D[Str:D] $words1,
    List:D[Str:D] $words2
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my Str @common;

    my %dict1;
     ++%dict1{ $_ } for @$words1;

    my %dict2;
     ++%dict2{ $_ } for @$words2;

    for %dict1.keys -> Str $key
    {
        if %dict1{ $key } == 1 and %dict2{$key}:exists and %dict2{ $key } == 1
        {
            @common.push: $key;
        }
    }

    @common .= sort;

    return @common;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words1-str, $words2-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $words1-str, $words2-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words1   = $words1-str.split:   / \s+ /, :skip-empty;
        my Str @words2   = $words2-str.split:   / \s+ /, :skip-empty;
        my Str @common   = find-common-words( @words1, @words2 );
        my Str @expected = $expected-str.split: / \s+ /, :skip-empty;

        is-deeply @common, @expected, $test-name;
    }

    done-testing;
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
        Example 1|Perl is my friend|Perl and Raku are friend|Perl friend
        Example 2|Perl and Python are very similar|Python is top in guest      \
                  languages|Python
        Example 3|Perl is imperative Lisp is functional|Crystal is similar to  \
                  Ruby|
        END

    $data ~~ s:g/ \\ \n \s* / /;                 # Concatenate backslashed lines

    return $data;
}

################################################################################
