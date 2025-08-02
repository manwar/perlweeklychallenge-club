use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 307
=========================

TASK #2
-------
*Find Anagrams*

Submitted by: Mohammad Sajid Anwar

You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop
the first word and keep the second. You continue this until there is no more
anagrams in the given list and return the count of final list.

Example 1

  Input: @words = ("acca", "dog", "god", "perl", "repl")
  Output: 3

  Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god"
      => ("acca", "god", "perl", "repl")
  Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl"
      => ("acca", "god", "repl")

Example 2

  Input: @words = ("abba", "baba", "aabb", "ab", "ab")
  Output: 2

  Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba"
      => ("baba", "aabb", "ab", "ab")
  Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb"
      => ("aabb", "ab", "ab")
  Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab"
      => ("aabb", "ab")

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of words is entered on the command-line.
3. If the input list is preceded by the "-i" flag, case is ignored. For example,
   "Abc" and "CaB" are considered anagrams. Otherwise (the default), character-
   comparisons are case-sensitive.
4. If the input list is preceded by the "-v" flag, the contents of the final
   list are also shown.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 307, Task #2: Find Anagrams (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Bool:D :i($ignore-case) = False,                #= Ignore case?
    Bool:D :v($verbose)     = False,                #= Show the final list?
             *@words where { .elems > 0 }           #= A non-empty list of words
)
#===============================================================================
{
    "Case-\nsensitive?  %s\n".printf: $ignore-case ?? 'No' !! 'Yes';
    "Input:      \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my Str @final = find-final-list( @words, $ignore-case );

    "Output:     %d\n".printf: @final.elems;

    "\nFinal list: (%s)\n".printf: @final.map( { qq["$_"] } ).join: ', '
        if $verbose;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-final-list
(
    List:D[Str:D] $words,
    Bool:D        $ignore-case = False
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my Str @new-list;

    for 0 .. $words.end - 1 -> UInt $i
    {
        @new-list.push: $words[ $i ]
            unless anagrams( $words[ $i ], $words[ $i + 1 ], $ignore-case );
    }

    @new-list.push: $words[ *-1 ];

    return @new-list;
}

#-------------------------------------------------------------------------------
sub anagrams( Str:D $word1, Str:D $word2, Bool:D $ignore-case --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $w1 = $word1.split( '', :skip-empty )\
                       .map( { $ignore-case ?? .lc !! $_ } ).sort.join;

    my Str $w2 = $word2.split( '', :skip-empty )\
                       .map( { $ignore-case ?? .lc !! $_ } ).sort.join;

    return $w1 eq $w2;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $expected) = $line.split: / \| /;

        for     $test-name, $words-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words      = $words-str.split: / \s+ /, :skip-empty;
        my Str @final-list = find-final-list( @words );

        is @final-list.elems, $expected.Int, $test-name;
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
        Example 1|acca dog god perl repl|3
        Example 2|abba baba aabb ab ab  |2
        END
}

################################################################################
