use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 377
=========================

TASK #2
-------
*Prefix Suffix*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to find if the two strings (str1, str2) in the given array such
that str1 is prefix and suffix of str2. Return the total count of such pairs.

Example 1

  Input: @array = ("a", "aba", "ababa", "aa")
  Output: 4

  $array[0], $array[1]: "a" is a prefix and suffix of "aba"
  $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
  $array[0], $array[3]: "a" is a prefix and suffix of "aa"
  $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"

Example 2

  Input: @array = ("pa", "papa", "ma", "mama")
  Output: 2

  $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
  $array[2], $array[3]: "ma" is a prefix and suffix of "mama"

Example 3

  Input: @array = ("abao", "ab")
  Output: 0

Example 4

  Input: @array = ("abab", "abab")
  Output: 1

  $array[0], $array[1]: "abab" is a prefix and suffix of "abab"

Example 5

  Input: @array = ("ab", "abab", "ababab")
  Output: 3

  $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
  $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
  $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"

Example 6

  Input: @array = ("abc", "def", "ghij")
  Output: 0

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
2. A non-empty list of strings is entered on the command-line.

Assumptions
-----------
1. It is clear that str1 and str2 must be different elements of the input list;
   that is, they must have different indices within the array.
2. But from Example 4 it appears that when str1 is identical to str2, the pair
   (str1, str2) does form a prefix/suffix pair. Now, Example 4 gives an expected
   count of 1, with the explanation: "abab" is a prefix and suffix of "abab".
   But in that case, both (str1, str2) and (str2, str1) are prefix/suffix pairs,
   and the count should be 2. The expected output in Example 4 has been adjusted
   accordingly in the test suite.
3. Comparisons are case-sensitive.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 377, Task #2: Prefix Suffix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of strings

    *@array where { .elems > 0 && .all ~~ Str:D }
)
#===============================================================================
{
    qq[Input:  \@array = (%s)\n].printf: @array.map( { qq["$_"] } ).join: ', ';

    my UInt $pairs = count-pairs( @array );

    "Output: $pairs".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-pairs( List:D[Str:D] $array --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for 0 .. $array.end -> UInt $i
    {
        my Str $str-i = $array[$i];

        for 0 .. $array.end -> UInt $j
        {
            next if $i == $j;

            ++$count if $array[$j] ~~ / ^ $str-i   / &&
                        $array[$j] ~~ /   $str-i $ /;
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $strs, $expected) = $line.split: '|';

        for     $test-name, $strs, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @array = $strs.split: / \s+ /, :skip-empty;
        my UInt $pairs = count-pairs( @array );

        is $pairs, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|a aba ababa aa |4
        Example 2|pa papa ma mama|2
        Example 3|abao ab        |0
        Example 4|abab abab      |2| Changed from 1. See Assumption 2 above
        Example 5|ab abab ababab |3
        Example 6|abc def ghij   |0
        END
}

################################################################################
