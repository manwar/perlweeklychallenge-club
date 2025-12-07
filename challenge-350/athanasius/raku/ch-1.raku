use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 350
=========================

TASK #1
-------
*Good Substrings*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the number of good substrings of length three in the
given string.

    A string is good if there are no repeated characters.

Example 1

  Input: $str = "abcaefg"
  Output: 5

  Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

  Input: $str = "xyzzabc"
  Output: 3

  Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

  Input: $str = "aababc"
  Output: 1

  Good substrings of length 3: "abc"

Example 4

  Input: $str = "qwerty"
  Output: 4

  Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example 5

  Input: $str = "zzzaaa"
  Output: 0

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
2. A single string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 350, Task #1: Good Substrings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $count = count-good-substrings( $str );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-good-substrings( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for 0 .. $str.chars - 3 -> UInt $i
    {
        my Str $x = $str.substr: $i,     1;
        my Str $y = $str.substr: $i + 1, 1;
        my Str $z = $str.substr: $i + 2, 1;

        ++$count if $x ne $y && $x ne $z && $y ne $z;
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
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $count = count-good-substrings( $str );

        is $count, $expected.Int, $test-name;
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
        Example 1|abcaefg|5
        Example 2|xyzzabc|3
        Example 3|aababc |1
        Example 4|qwerty |4
        Example 5|zzzaaa |0
        END
}

################################################################################
