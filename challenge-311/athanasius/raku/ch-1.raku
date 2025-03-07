use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 311
=========================

TASK #1
-------
*Upper Lower*

Submitted by: Mohammad Sajid Anwar

You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in the given string.

Example 1

  Input: $str = "pERl"
  Output: "PerL"

Example 2

  Input: $str = "rakU"
  Output: "RAKu"

Example 3

  Input: $str = "PyThOn"
  Output: "pYtHoN"

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
2. A single string containing only letters of the English alphabet is entered on
   the command-line.

=end comment
#===============================================================================

use Test;

subset Letters of Str where * ~~ rx:i/ ^ <[ a .. z ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 311, Task #1: Upper Lower (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Letters:D $str              #= A string of letters from the English alphabet
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Letters $converted = convert-upper-lower( $str );

    qq[Output:       "$converted"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub convert-upper-lower( Letters:D $str --> Letters:D )
#-------------------------------------------------------------------------------
{
    return TR/A..Za..z/a..zA..Z/ with $str;
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

        my Letters $converted = convert-upper-lower( $str );

        is $converted, $expected, $test-name;
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
        Example 1|pERl  |PerL
        Example 2|rakU  |RAKu
        Example 3|PyThOn|pYtHoN
        END
}

################################################################################
