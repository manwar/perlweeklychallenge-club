use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 330
=========================

TASK #1
-------
*Clear Digits*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest
non-digit character to its left.

Example 1

  Input: $str = "cab12"
  Output: "c"

  Round 1: remove "1" then "b" => "ca2"
  Round 2: remove "2" then "a" => "c"

Example 2

  Input: $str = "xy99"
  Output: ""

  Round 1: remove "9" then "y" => "x9"
  Round 2: remove "9" then "x" => ""

Example 3

  Input: $str = "pa1erl"
  Output: "perl"

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
2. A string containing only lower case English letters and digits is entered on
   the command-line.

Assumptions
-----------
At each step of the process:
1. it is the left-most digit that is removed; and
2. if there are no non-digit characters to its left, only the digit is removed.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 330, Task #1: Clear Digits (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string containing only lower-case English letters and digits

    Str:D $str where / ^ <[ a..z 0..9 ]>* $ /
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $cleared = clear-digits( $str );

    qq[Output:       "$cleared"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub clear-digits( Str:D $str where / ^ <[ a..z 0..9 ]>* $ / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $cleared = $str;

    Nil while $cleared ~~ s/ [ ^ || \D ] \d //;

    return $cleared;
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

        my Str $cleared = clear-digits( $str );

        is $cleared, $expected, $test-name;
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
        Example 1|cab12 |c
        Example 2|xy99  |
        Example 3|pa1erl|perl
        END
}

################################################################################
