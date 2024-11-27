use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 295
=========================

TASK #1
-------
*Word Break*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be segmented
into a space separated sequence of one or more words from the given list.

Example 1

  Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
  Output: true

Example 2

  Input: $str = "perlrakuperl", @words = ("raku", "perl")
  Output: true

Example 3

  Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Neither $str nor the elements of @words contain whitespace characters.
2. There must be at least one element in @words.
3. Every element of @words must contain at least one character.
4. String comparisons are case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string, and a non-empty list of words, are entered on the command-line.

Algorithm
---------
Recursive search: For each entry in the @words list, check whether it matches at
the very beginning of the string. If it does, remove it and continue the search
recursively on the string that remains. If at any point the string reduces to
the empty string, the search is successful. Otherwise, the search fails.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 295, Task #1: Word Break (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string to be segmented (no whitespace)

    Str:D $str where { !/ \s / },

    #| A non-empty list of strings (each not empty, no whitespace)

    *@words where { .elems     > 0 && .all  ~~ Str:D &&
                    .all.chars > 0 && .none ~~ / \s / }
)
#===============================================================================
{
    "Input:  \$str = '%s', \@words = (%s)\n".printf:
        $str, @words.map( { qq["$_"] } ).join: ', ';

    my Bool $can-segment = can-segment-str( $str, @words );

    "Output: %s\n".printf: $can-segment ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub can-segment-str( Str:D $str, List:D[Str:D] $words --> Bool:D )
#-------------------------------------------------------------------------------
{
    return True if $str eq '';                                  # Base case 1

    for @$words -> Str $word
    {
        if $str ~~ / ^ $word /
        {
            my Str $str1 = S/ ^ $word // with $str;             # Reductive step

            return True if can-segment-str( $str1, $words );    # Recursive call
        }
    }

    return False;                                               # Base case 2
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $words-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $str, $words-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @words       = $words-str.split: / \s+ /, :skip-empty;
        my Bool $can-segment = can-segment-str( $str, @words );
        my Bool $expected    = $exp-str eq 'true';

        is $can-segment, $expected, $test-name;
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
        Example 1|weeklychallenge |challenge weekly         |true
        Example 2|perlrakuperl    |raku perl                |true
        Example 3|sonsanddaughters|sons sand daughters      |false
        Overlap  |fishnetworkplace|network fishnet workplace|true
        END
}

################################################################################
