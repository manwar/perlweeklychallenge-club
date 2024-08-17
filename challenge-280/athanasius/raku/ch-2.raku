use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 280
=========================

TASK #2
-------
*Count Asterisks*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, where every two consecutive vertical bars are
grouped into a pair.

Write a script to return the number of asterisks, *, excluding any between each
pair of vertical bars.

Example 1

  Input: $str = "p|*e*rl|w**e|*ekly|"
  Output: 2

  The characters we are looking here are "p" and "w**e".

Example 2

  Input: $str = "perl"
  Output: 0

Example 3

  Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
  Output: 5

  The characters we are looking here are "th", "e**", "l***ych" and "e".

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
Otherwise:
2. A single string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 280, Task #2: Count Asterisks (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $asterisks = count-asterisks( $str );

    "Output: $asterisks".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-asterisks( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    # 1. Make of copy of $str with all bar-pairs (including any asterisks they
    #    contain) removed

    my Str $s = S:g/ \| <-[ | ]>* \| // with $str;

    # 2. Return the number of asterisks remaining

    return +( $s ~~ tr/*// );
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \! /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $asterisks = count-asterisks( $str );

        is $asterisks, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1     ! p|*e*rl|w**e|*ekly|           ! 2
        Example 2     ! perl                          ! 0
        Example 3     ! th|ewe|e**|k|l***ych|alleng|e ! 5
        Unmatched bar ! a*a|b**b|c***|d****d          ! 8
        END
}

################################################################################
