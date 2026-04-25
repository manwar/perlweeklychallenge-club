use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 370
=========================

TASK #2
-------
*Scramble String*

Submitted by: Roger Bell_West

You are given two strings A and B of the same length.

Write a script to return true if string B is a scramble of string A otherwise
return false.

String B is a scramble of string A if A can be transformed into B by a single
(recursive) scramble operation.

A scramble operation is:

  - If the string consists of only one character, return the string.
  - Divide the string X into two non-empty parts.
  - Optionally, exchange the order of those parts.
  - Optionally, scramble each of those parts.
  - Concatenate the scrambled parts to return a single string.

Example 1

  Input: $str1 = "abc", $str2 = "acb"
  Output: true

  "abc"
  split: ["a", "bc"]
  split: ["a", ["b", "c"]]
  swap: ["a", ["c", "b"]]
  concatenate: "acb"

Example 2

  Input: $str1 = "abcd", $str2 = "cdba"
  Output: true

  "abcd"
  split: ["ab", "cd"]
  swap: ["cd", "ab"]
  split: ["cd", ["a", "b"]]
  swap: ["cd", ["b", "a"]]
  concatenate: "cdba"

Example 3

  Input: $str1 = "hello", $str2 = "hiiii"
  Output: false

  A fundamental rule of scrambled strings is that they must be anagrams.

Example 4

  Input: $str1 = "ateer", $str2 = "eater"
  Output: true

  "ateer"
  split: ["ate", "er"]
  split: [["at", "e"], "er"]
  swap: [["e", "at"], "er"]
  concatenate: "eater"

Example 5

  Input: $str1 = "abcd", $str2 = "bdac"
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings of the same length are entered on the command-line.

Assumption
----------
Two identical strings are scrambles of each other (the degenerate case).

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 370, Task #2: Scramble String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str1,                                   #= A string
    Str:D $str2 where { .chars == $str1.chars }    #= Another string of the same
                                                   #= length
)
#===============================================================================
{
    qq[Input:  \$str1 = "$str1", \$str2 = "$str2"].put;

    my Bool $are-scrambles = are-scrambles( $str1, $str2 );

    qq[Output: %s\n].printf: $are-scrambles ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub are-scrambles
(
    Str:D $str1,
    Str:D $str2 where { .chars == $str1.chars }
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    return True if $str1 eq $str2;                        # See Assumption above

    if are-anagrams( $str1, $str2 )                       # See Example 3
    {
        for scramble( $str1 ) -> Str $scramble
        {
            return True if $scramble eq $str2;
        }
    }

    return False;
}

#-------------------------------------------------------------------------------
sub scramble( Str:D $str --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my SetHash $scrambles = SetHash.new;

    if $str.chars > 1
    {
        for 1 .. $str.chars - 1 -> UInt $i                   # Divide the string
        {
            my Str $left-str  = $str.substr: 0, $i;
            my Str $right-str = $str.substr: $i;
                                                              # Recursive calls:
            for $left-str, |scramble( $left-str ) -> Str $left             # (1)
            {
                for $right-str, |scramble( $right-str ) -> Str $right      # (2)
                {
                    # Concatenate, with and without reversal

                    $scrambles.set: ("$left$right", "$right$left");
                }
            }
        }
    }
    else
    {
        $scrambles.set: $str;                                        # Base case
    }

    return $scrambles.keys.list;
}

#-------------------------------------------------------------------------------
sub are-anagrams( Str:D $str1, Str:D $str2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $str1_ordered = $str1.split( '', :skip-empty ).sort.join;
    my Str $str2_ordered = $str2.split( '', :skip-empty ).sort.join;

    return $str1_ordered eq $str2_ordered;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $expected) = $line.split: / \| /;

        for     $test-name, $str1, $str2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $are-scrambles =
                are-scrambles( $str1, $str2 ) ?? 'true' !! 'false';

        is $are-scrambles, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    # It is assumed that *test* data strings do not begin or end with whitespace

    return q:to/END/;
        Example 1|abc  |acb  |true
        Example 2|abcd |cdba |true
        Example 3|hello|hiiii|false
        Example 4|ateer|eater|true
        Example 5|abcd |bdac |false
        Identical|abcde|abcde|true
        END
}

################################################################################
