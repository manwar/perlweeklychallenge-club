use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 351
=========================

TASK #2
-------
*Arithmetic Progression*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form an
arithmetic progression, otherwise return false.

    A sequence of numbers is called an arithmetic progression if the difference
    between any two consecutive elements is the same.

Example 1

  Input: @num = (1, 3, 5, 7, 9)
  Output: true

  Already AP with common difference 2.

Example 2

  Input: @num = (9, 1, 7, 5, 3)
  Output: true

  The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3

  Input: @num = (1, 2, 4, 8, 16)
  Output: false

  This is geometric progression and not arithmetic progression.

Example 4

  Input: @num = (5, -1, 3, 1, -3)
  Output: true

  The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

Example 5

  Input: @num = (1.5, 3, 0, 4.5, 6)
  Output: true

  The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference
  1.5.

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
2. A non-empty list of numbers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 351, Task #2: Arithmetic Progression (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of numbers

    *@num where { .elems > 0 && .all ~~ Real:D }
)
#===============================================================================
{
    "Input:  \@num = (%s)\n".printf: @num.join: ', ';

    my Bool $arith-prog = is-arithmetic-progression( @num );

    "Output: %s\n".printf: $arith-prog ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-arithmetic-progression( List:D[Real:D] $num --> Bool:D )
#-------------------------------------------------------------------------------
{
    if $num.elems > 1
    {
        my Real @sorted     = $num.sort;
        my Real $difference = @sorted[1] - @sorted[0];

        for 2 .. @sorted.end -> UInt $i
        {
            return False unless @sorted[$i] - @sorted[$i - 1] == $difference;
        }
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $num-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Real @num        = $num-str.split( / \s+ / ).map: { .Real };
        my Bool $arith-prog = is-arithmetic-progression( @num );
        my Bool $expected   = $exp-str eq 'true';

        is $arith-prog, $expected, $test-name;
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
        Example 1|1   3 5 7   9|true
        Example 2|9   1 7 5   3|true
        Example 3|1   2 4 8  16|false
        Example 4|5  -1 3 1  -3|true
        Example 5|1.5 3 0 4.5 6|true
        END
}

################################################################################
