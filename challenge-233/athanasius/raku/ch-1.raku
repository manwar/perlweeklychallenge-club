use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 233
=========================

TASK #1
-------
*Similar Words*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabets only.

Write a script to find the number of pairs of similar words. Two words are
similar if they consist of the same characters.

Example 1

  Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
  Output: 2

  Pair 1: similar words ("aba", "aabb")
  Pair 2: similar words ("bac", "aabc")

Example 2

  Input: @words = ("aabb", "ab", "ba")
  Output: 3

  Pair 1: similar words ("aabb", "ab")
  Pair 2: similar words ("aabb", "ba")
  Pair 3: similar words ("ab", "ba")

Example 3

  Input: @words = ("nba", "cba", "dba")
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Identical strings in the input are treated as distinct for the enumeration of
   similar pairs. E.g., an input of "abc abc abc" should yield an output of 3.
2. Case is ignored for the purposes of comparison (i.e., for determining whether
   two words are "similar"), but retained in the enumeration of similar pairs.
   So, e.g., an input of "abc ABC BcA" should yield an output of 3:
       Pair 1: ("abc", "ABC")
       Pair 2: ("abc", "BcA")
       Pair 3: ("ABC", "BcA").

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True (the default), the output is followed by a list of
   the similar pairs found.

=end comment
#===============================================================================

use Test;

subset Alpha of Str  where m:i/ ^ <[ a..z ]>+ $ /;
subset APair of List where (Alpha, Alpha);

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 233, Task #1: Similar Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of alphabetical-character words

    *@words where { .elems > 0 && .all ~~ Alpha:D }
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my Array[APair] $pairs = find-pairs( @words );
    my UInt         $count = $pairs.elems;

    "Output: $count".put;

    if $VERBOSE && $count > 0
    {
        put();
        my UInt $n = 1;

        for @$pairs -> APair $pair
        {
            qq[Pair %d: similar words ("%s", "%s")\n].printf: $n++, @$pair;
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-pairs( List:D[Alpha:D] $words --> List:D[APair:D] )
#-------------------------------------------------------------------------------
{
    my Set %dict{Str};

    for @$words -> Alpha $word
    {
        %dict{ $word } = set $word.lc.split: '', :skip-empty;
    }

    my APair @pairs;

    for 0 .. $words.end - 1 -> UInt $i
    {
        my Alpha $word1 = $words[ $i ];

        for $i + 1 .. $words.end -> UInt $j
        {
            my Alpha $word2 = $words[ $j ];

            # Note: ≡ is the identity operator, also written (==)

            @pairs.push: Array[Alpha].new( $word1, $word2 )
                if %dict{ $word1 } ≡ %dict{ $word2 };
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exp-str, @exp-pair-strs) =
                $line.split: / \| /;

        for     $test-name, $words-str, $exp-str, @exp-pair-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Alpha        @words     = $words-str.split: / \s+ /, :skip-empty;
        my Array[APair] $exp-pairs = Array[APair].new();

        for @exp-pair-strs -> Str $pair-str
        {
            $exp-pairs.push: Array[Alpha].new:
                $pair-str.split: / \s+ /, :skip-empty
                    if $pair-str.chars > 0;
        }

        my Array[APair] $pairs = find-pairs( @words );
        my UInt         $count = $pairs.elems;

        is        $count, $exp-str.Int, "$test-name: Count";
        is-deeply $pairs, $exp-pairs,   "$test-name: Pairs";
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
    return q:to/END/;
        Example 1 |aba aabb abcd bac aabc|2|aba aabb|bac aabc
        Example 2 |aabb ab ba            |3|aabb ab |aabb ba |ab ba
        Example 3 |nba cba dba           |0|
        Upper case|abc ABC aAbc          |3|abc ABC |abc aAbc|ABC aAbc
        END
}

################################################################################
