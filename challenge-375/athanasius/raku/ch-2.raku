use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 375
=========================

TASK #2
-------
*Find K-Beauty*

Submitted by: Mohammad Sajid Anwar

You are given a number and a digit (k).

Write a script to find the K-Beauty of the given number. The K-Beauty of an
integer number is defined as the number of substrings of given number when it is
read as a string has length of 'k' and is a divisor of given number.

Example 1

  Input: $num = 240, $k = 2
  Output: 2

  Substring with length 2:
  24: 240 is divisible by 24
  40: 240 is divisible by 40

Example 2

  Input: $num = 1020, $k = 2
  Output: 3

  Substring with length 2:
  10: 1020 is divisible by 10
  02: 1020 is divisible by 2
  20: 1020 is divisible by 20

Example 3

  Input: $num = 444, $k = 2
  Output: 0

  Substring with length 2:
  First "44": 444 is not divisible by 44
  Second "44": 444 is not divisible by 44

Example 4

  Input: $num = 17, $k = 2
  Output: 1

  Substring with length 2:
  17: 17 is divisible by 17

Example 5

  Input: $num = 123, $k = 1
  Output: 2

  Substring with length 1:
  1: 123 is divisible by 1
  2: 123 is not divisible by 2
  3: 123 is divisible by 3

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
2. An integer is entered on the command-line, followed by a digit.
3. If the integer is negative, it must be preceded by "--" to indicate that it
   is not a command-line flag.

Assumptions
-----------
1. $k must be greater than 0.
2. $num is initially treated as an integer, not a string, so if $num is entered
   as, say, "002", it is first normalized to 2 and only then treated as a string
   from which substrings may be extracted.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 375, Task #2: Find K-Beauty (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D  $num,                                #= An integer
    UInt:D $k where { 9 >= $k >= 1 }            #= A non-zero digit
)
#===============================================================================
{
    my Str $num-str = ~$num;

    $num-str ~~ s/ ^ (<[+-]>*) 0+ /$0/;

    "Input:  \$num = $num-str, \$k = $k".put;

    my UInt $k-beauty = find-k-beauty( $num-str.Int, $k );

    "Output: $k-beauty".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-k-beauty( Int:D $num, UInt:D $k where { 9 >= $k >= 1 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Str  $num-str  = ~$num;
            $num-str ~~ s/ ^ <-[ 0 .. 9 ]>+ //;
    my UInt $k-beauty = 0;

    for 0 .. $num-str.chars - $k -> UInt $i
    {
        my UInt $divisor = $num-str.substr( $i, $k ).Int;

        ++$k-beauty if $num %% $divisor;
    }

    return $k-beauty;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num, $k, $expected) = $line.split: '|';

        for     $test-name, $num, $k, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $k-beauty = find-k-beauty( $num.Int, $k.Int );

        is $k-beauty, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1    | 240|2|2
        Example 2    |1020|2|3
        Example 3    | 444|2|0
        Example 4    |  17|2|1
        Example 5    | 123|1|2
        Leading zeros| 002|2|0
        END
}

################################################################################
