use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 314
=========================

TASK #1
-------
*Equal Strings*

Submitted by: Mohammad Sajid Anwar

You are given three strings.

You are allowed to remove the rightmost character of a string to make all
equals.

Write a script to return the number of operations to make it equal otherwise -1.

Example 1

  Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
  Output: 2

  Operation 1: Delete "c" from the string "abc"
  Operation 2: Delete "b" from the string "abb"

Example 2

  Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
  Output: -1

Example 3

  Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
  Output: 3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Removal of the rightmost character may be performed only once on each string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Three strings are entered on the command-line.

Analysis
--------
There are 8 possible sets of operations ('x' = remove rightmost char):

    #   s1      s2      s3      Output
--------------------------------------
    1    -       -       -        0
    2    x       -       -        1
    3    -       x       -        1
    4    -       -       x        1
    5    x       x       -        2
    6    x       -       x        2
    7    -       x       x        2
    8    x       x       x        3

and 5 possible outcomes:  -1, 0, 1, 2, 3

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 314, Task #1: Equal Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $s1,                         #= First  string
    Str:D $s2,                         #= Second string
    Str:D $s3                          #= Third  string
)
#===============================================================================
{
    qq[Input:  \$s1 = "$s1", \$s2 = "$s2", \$s3 = "$s3"].put;

    my Int $operations = solve( $s1, $s2, $s3 );

    "Output: $operations".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub solve( Str:D $s1, Str:D $s2, Str:D $s3 --> Int:D )
#-------------------------------------------------------------------------------
{
    return  0 if strings-are-equal( $s1,      $s2,      $s3      );

    return  1 if strings-are-equal( $s1.chop, $s2,      $s3      ) ||
                 strings-are-equal( $s1,      $s2.chop, $s3      ) ||
                 strings-are-equal( $s1,      $s2,      $s3.chop );

    return  2 if strings-are-equal( $s1.chop, $s2.chop, $s3      ) ||
                 strings-are-equal( $s1.chop, $s2,      $s3.chop ) ||
                 strings-are-equal( $s1,      $s2.chop, $s3.chop );

    return  3 if strings-are-equal( $s1.chop, $s2.chop, $s3.chop );

    return -1;
}

#-------------------------------------------------------------------------------
sub strings-are-equal( Str:D $s1, Str:D $s2, Str:D $s3 --> Bool:D )
#-------------------------------------------------------------------------------
{
    return $s1 eq $s2 && $s2 eq $s3;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s1, $s2, $s3, $expected) = $line.split: / \| /;

        for     $test-name, $s1, $s2, $s3, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int $operations = solve( $s1, $s2, $s3 );

        is $operations, $expected.Int, $test-name;
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
        Example 1|abc|abb|ab | 2
        Example 2|ayz|cyz|xyz|-1
        Example 3|yza|yzb|yzc| 3
        All same |ABC|ABC|ABC| 0
        END
}

################################################################################
