use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 282
=========================

TASK #1
-------
*Good Integer*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int, having 3 or more digits.

Write a script to return the Good Integer in the given integer or -1 if none
found.

    A good integer is exactly three consecutive matching digits.

Example 1

  Input: $int = 12344456
  Output: "444"

Example 2

  Input: $int = 1233334
  Output: -1

Example 3

  Input: $int = 10020003
  Output: "000"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer of 3 or more digits is entered on the command-line.

Assumptions
-----------
1. Since the input integer must have at least 3 digits, and valid integers do
   not have leading zeros, the smallest valid input integer is 100.
2. A leading plus ("+") sign is also disallowed: only the digits 0-9 are accept-
   ed.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 282, Task #1: Good Integer (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A positive integer of 3 or more digits

    Str:D $int where / ^ <[ 1..9 ]> \d ** 2..* /
)
#===============================================================================
{
    "Input: \$int = $int".put;

    my Str $good-int = find-good-integer( $int.Int );

    "Output: $good-int".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-good-integer( UInt:D $int where * >= 100 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @runs = ($int ~~ m:g/ ( (\d) {} :my $n = $0; $n ** 2..* ) /)\
                   .map( { ~$_ } ).grep: { .chars == 3 };

    return @runs.elems ?? qq["@runs[ 0 ]"] !! '-1';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $expected) = $line.split: / \| /;

        for     $test-name, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $good-int = find-good-integer( $int.Int );

        is $good-int, $expected, $test-name;
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
        Example 1   |12344456          |"444"
        Example 2   |1233334           |-1
        Example 3   |10020003          |"000"
        Multiple    |122234445666      |"222"
        Initial     |9992555           |"999"
        Final       |123776666888      |"888"
        Final 4     |123456789999      |-1
        All too long|111112222333334444|-1
        Between 4s  |122223334444567   |"333"
        END
}

################################################################################
