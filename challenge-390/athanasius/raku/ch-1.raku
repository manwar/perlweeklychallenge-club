use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 390
=========================

TASK #1
-------
*Decode String*

Submitted by: Mohammad Sajid Anwar

You are given an encoded string.

Write a script to return the decoded string of the given encoded string.

  The encoding rule is: K[encoded_string], where the encoded_string inside the
  square brackets is repeated exactly K > 0 times.

Example 1

  Input: $str = "2[3[a]]"
  Output: "aaaaaa"

  3[a]    => aaa
  2[3[a]] => aaa aaa

Example 2

  Input: $str = "10[a]"
  Output: "aaaaaaaaaa"

Example 3

  Input: $str = "a2[b]c3[d]e"
  Output: "abbcddde"

Example 4

  Input: $str = "2[a2[b]c]"
  Output: "abbcabbc"

Example 5

  Input: $str = "1[a]2[b3[c]]"
  Output: "abcccbccc"

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
2. A single encoded string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 390, Task #1: Decode String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                       #= An encoded string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str $decoded = decode-string( $str );

    qq[Output: "$decoded"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub decode-string( Str:D $str is copy --> Str:D )
#-------------------------------------------------------------------------------
{
    Nil while $str ~~ s:g/ (\d+) \[ (<-[ \[ \] ]>+) \] /{$1 x $0}/;

    return $str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $encoded-str, $expected) = $line.split: '|';

        for     $test-name, $encoded-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $decoded = decode-string( $encoded-str );

        is $decoded, $expected, $test-name;
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
        Example 1|2[3[a]]     |aaaaaa
        Example 2|10[a]       |aaaaaaaaaa
        Example 3|a2[b]c3[d]e |abbcddde
        Example 4|2[a2[b]c]   |abbcabbc
        Example 5|1[a]2[b3[c]]|abcccbccc
        END
}

################################################################################
