use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 393
=========================

TASK #2
-------
*Prime Step*

Submitted by: Ulrich Rieke

You are given a string with English alphabetic characters only.

What is the absolute difference of the sum of the ASCII values of the characters
in the string to the nearest prime number?

Example 1

  Input: $str = "hello"
  Output: 9

  The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
  The nearest prime number to 532 is 523, resulting in an absolute difference of
  9.

Example 2

  Input: $str = "football"
  Output: 2

  Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
  We find 839 as the nearest prime number, so the difference is 2.

Example 3

  Input: $str = "a"
  Output: 0

Example 4

  Input: $str = "challenge"
  Output: 2

  The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103,
  101], which sum up to 931.
  The nearest prime number to 931 is 929, so the difference is 2.

Example 5

  Input: $str = "perl"
  Output: 2

  The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
  Nearest prime is 433, so the difference is 2.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
"English alphabetic characters" are the letters 'A' to 'Z' and 'a' to 'z' only.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of one or more English letters is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 393, Task #2: Prime Step (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of one or more letters from the English alphabet

    Str:D $str where { / ^ <[ A..Z a..z ]>+ $ / }

)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $prime-step = find-prime-step( $str );

    "Output: $prime-step".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-prime-step( Str:D $str where { / ^ <[ A..Z a..z ]>+ $ / } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $step = 0;
    my UInt $sum  = [+] $str.split( '', :skip-empty ).map: { .ord };

    unless $sum.is-prime
    {
        my UInt $next  = $sum %% 2 ?? $sum + 1 !! $sum + 2;
                $next += 2 until $next.is-prime;

        my UInt $prev  = $sum %% 2 ?? $sum - 1 !! $sum - 2;
                $prev -= 2 until $prev.is-prime;

        $step = ($next - $sum, $sum - $prev).min;
    }

    return $step;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $prime-step = find-prime-step( $str );

        is $prime-step, $expected.Int, $test-name;
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
        Example 1|hello    |9
        Example 2|football |2
        Example 3|a        |0
        Example 4|challenge|2
        Example 5|perl     |2
        END
}

################################################################################
