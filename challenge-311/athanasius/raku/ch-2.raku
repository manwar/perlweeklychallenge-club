use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 311
=========================

TASK #2
-------
*Group Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of digits, and an integer, $int, which is
less than the length of the given string.

Write a script to divide the given string into consecutive groups of size $int
(plus one for leftovers if any). Then sum the digits of each group, and con-
catenate all group sums to create a new string. If the length of the new string
is less than or equal to the given integer then return the new string, otherwise
continue the process.

Example 1

  Input: $str = "111122333", $int = 3
  Output: "359"

  Step 1: "111", "122", "333" => "359"

Example 2

  Input: $str = "1222312", $int = 2
  Output: "76"

  Step 1: "12", "22", "31", "2" => "3442"
  Step 2: "34", "42" => "76"

Example 3

  Input: $str = "100012121001", $int = 4
  Output: "162"

  Step 1: "1000", "1212", "1001" => "162"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. If $int = 1, the summing operation leaves the string unchanged and so the
   algorithm never terminates. Therefore, $int > 1.
2. Since $int >= 2 and < (length of $str), $str must contain at least 3 digits.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string $str of 3 or more digits is entered on the command-line, followed by
   an integer $int such that 1 < $int < (length of $str).

=end comment
#===============================================================================

use Test;

subset Digits of Str where * ~~ rx/ ^ <[ 0 .. 9 ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 311, Task #2: Group Digit Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Digits:D $str where { .chars >= 3 },    #= A string of three or more digits

    #| An integer greater than one and less than the length of $str

    UInt:D   $int where { 1 < $int < $str.chars }
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$int = $int].put;

    my Digits $sum = group-digit-sum( $str, $int );

    qq[Output: "$sum"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub group-digit-sum
(
    Digits:D $str where { .chars >= 3 },
    UInt:D   $int where { 1 < $_ < $str.chars },
--> Digits:D
)
#-------------------------------------------------------------------------------
{
    my UInt @digits = $str.split( '', :skip-empty ).map: { .Int };

    while @digits.elems > $int
    {
        my UInt @sum;

        while @digits
        {
            my UInt $sum = 0;

            for 1 .. $int
            {
                $sum += @digits.shift if @digits;
            }

            push @sum, |$sum.split( '', :skip-empty ).map: { .Int };
        }

        @digits = @sum;
    }

    return @digits.join;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $int, $expected) = $line.split: / \| /;

        for     $test-name, $str, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Digits $sum = group-digit-sum( $str, $int.Int );

        is $sum, $expected, $test-name;
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
        Example 1|111122333   |3|359
        Example 2|1222312     |2|76
        Example 3|100012121001|4|162
        Max pairs|999999      |2|99
        END
}

################################################################################
