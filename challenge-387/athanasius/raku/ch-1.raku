use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 387
=========================

TASK #1
-------
*Rearrange Binary String*

Submitted by: Mohammad Sajid Anwar

You are given a binary string.

Write a script to re-arrange the given binary string [so] that all occurrences
of “01” are simultaneously replaced with “10” until no occurrences of “01”
exist. Finally return the total steps needed.

Example 1

  Input: $str = "111000"
  Output: 0

  The string already has all 1s on the left and 0s on the right.
  There are no occurrences of "01", so zero step needed.

Example 2

  Input: $str = "00011"
  Output: 4

  Step 1: "00101"
  Step 2: "01010"
  Step 3: "10100"
  Step 4: "11000"

Example 3

  Input: $str = "01011"
  Output: 3

  Step 1: "10101"
  Step 2: "11010"
  Step 3: "11100"

Example 4

  Input: $str = "010101"
  Output: 3

  Step 1: "101010"
  Step 2: "110100"
  Step 3: "111000"

Example 5

  Input: $str = "00001"
  Output: 4

  Step 1: "00010"
  Step 2: "00100"
  Step 3: "01000"
  Step 4: "10000"

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
2. A binary string is entered on the command-line.
3. If this binary string is preceded by the flags "-v" or "--verbose" then the
   steps are detailed, as in the Examples.

=end comment
#===============================================================================

use Test;

subset BinStr of Str where / ^ <[ 0 1 ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 387, Task #1: Rearrange Binary String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BinStr:D $str,                              #= A binary string
    Bool:D   :v(:$verbose) = False              #= Show the steps?
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $steps = count-steps( $str, $verbose );

    "Output: $steps".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-steps( BinStr:D $str is copy, Bool:D $verbose = False --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $step = 0;

    while $str ~~ / 01 /
    {
        $str ~~ s:g/ 01 /10/;

        ++$step;

        if $verbose
        {
            put() if $step == 1;

            qq[  Step %d: "%s"\n].printf: $step, $str;
        }
    }

    put() if $verbose && $step > 0;

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

        my UInt $steps = count-steps( $str );

        is $steps, $expected.Int, $test-name;
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
        Example 1|111000|0
        Example 2|00011 |4
        Example 3|01011 |3
        Example 4|010101|3
        Example 5|00001 |4
        END
}

################################################################################
