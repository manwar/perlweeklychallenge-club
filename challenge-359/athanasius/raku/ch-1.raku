use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 359
=========================

TASK #1
-------
*Digital Root*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer
and also return the digital root.

    Digital root is the recursive sum of all digits in a number until a single
    digit is obtained.

    Additive persistence is the number of times you need to sum the digits to
    reach a single digit.

Example 1

  Input: $int = 38
  Output: Persistence  = 2
          Digital Root = 2

  38 => 3 + 8 => 11
  11 => 1 + 1 => 2

Example 2

  Input: $int = 7
  Output: Persistence  = 0
          Digital Root = 7

Example 3

  Input: $int = 999
  Output: Persistence  = 2
          Digital Root = 9

  999 => 9 + 9 + 9 => 27
  27  => 2 + 7 => 9

Example 4

  Input: $int = 1999999999
  Output: Persistence  = 3
          Digital Root = 1

  1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
  82 => 8 + 2 => 10
  10 => 1 + 0 => 1

Example 5

  Input: $int = 101010
  Output: Persistence  = 1
          Digital Root = 3

  101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is an integer greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive (non-zero) integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos    of Int  where * > 0;
subset Result of List where (UInt, Pos);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 359, Task #1: Digital Root (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $int                      #= A positive integer
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my Result $result = find-persistence-and-root( $int );

    "Output: Persistence  = %d\n        Digital Root = %d\n".printf: @$result;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-persistence-and-root( Pos:D $int --> Result:D )
#-------------------------------------------------------------------------------
{
    my UInt $pers = 0;
    my Pos  $sum  = $int;

    while $sum > 9
    {
        $sum = [+] $sum.split( '', :skip-empty ).map: { .Int };
        ++$pers;
    }

    return $pers, $sum;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $exp-pers, $exp-root) = $line.split: / \| /;

        for     $test-name, $int, $exp-pers, $exp-root
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Result $result = find-persistence-and-root( $int.Int );

        is $result[0], $exp-pers.Int, "$test-name: Persistence";
        is $result[1], $exp-root.Int, "$test-name: Digital Root";
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
        Example 1|        38|2|2
        Example 2|         7|0|7
        Example 3|       999|2|9
        Example 4|1999999999|3|1
        Example 5|    101010|1|3
        END
}

################################################################################
