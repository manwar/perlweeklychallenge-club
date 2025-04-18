use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 317
=========================

TASK #1
-------
*Acronyms*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a word.

Write a script to return true if concatenating the first letter of each word in
the given array matches the given word, return false otherwise.

Example 1

  Input: @array = ("Perl", "Weekly", "Challenge")
         $word  = "PWC"
  Output: true

Example 2

  Input: @array = ("Bob", "Charlie", "Joe")
         $word  = "BCJ"
  Output: true

Example 3

  Input: @array = ("Morning", "Good")
         $word  = "MM"
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Matching is NOT case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An acronym is entered on the command-line, followed by a list of words.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 317, Task #1: Acronyms (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $word,                                    #= An acronym
         *@array where { .elems > 0 }               #= A non-empty list of words
)
#===============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.map( { qq["$_"] } ).join: ', ';
    "        \$word  =  \"$word\"".put;

    my Bool $acronym = is-acronym( @array, $word );

    "Output: %s\n".printf: $acronym ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-acronym( List:D[Str:D] $array, Str:D $word --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $acronym;

    for @$array -> Str $elem
    {
        $acronym ~= $elem.substr: 0, 1;
    }

    return $acronym.lc eq $word.lc;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $array-str, $word, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $array-str, $word, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @array    = $array-str.split: / \s+ /, :skip-empty;
        my Bool $acronym  = is-acronym( @array, $word );
        my Bool $expected = $expected-str eq 'true';

        is $acronym, $expected, $test-name;
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
    return q:to/END/;
        Example 1|Perl Weekly Challenge|PWC|true
        Example 2|Bob Charlie Joe      |BCJ|true
        Example 3|Morning Good         |MM |false
        Diff case|don't repeat yourself|DRY|true
        END
}

################################################################################
