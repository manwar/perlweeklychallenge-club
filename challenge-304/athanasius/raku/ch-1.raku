use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 304
=========================

TASK #1
-------
*Arrange Binary*

Submitted by: Mohammad Sajid Anwar

You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at
least $n digits with 1 in the given list so that no two consecutive digits are 1
otherwise return false.

Example 1

  Input: @digits = (1, 0, 0, 0, 1), $n = 1
  Output: true

  Re-arranged list: (1, 0, 1, 0, 1)

Example 2

  Input: @digits = (1, 0, 0, 0, 1), $n = 2
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Replacement: Only a 0 digit may be replaced with a 1 digit.
2. The given $n must be greater than zero.

Discussion
----------
In the Task description, juxtaposition of the words "re-arrange" and "replace"
creates ambiguity. Is the requirement to:

 1. replace $n 0 digits with 1 digits, leaving them in their original places; or
 2. rearrange all the digits (after replacement) into the required sequence?

Rather than choose between these alternatives, I have decided to solve both. For
example, an input of @digits = (1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1) and $n = 1 will
produce the following result:

    Input: @digits = (1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1), $n = 1
    Output
      Can rearrange: true
      Can replace:   false

which indicates that the digits CAN be re-arranged with no two consecutive 1s:

    (1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1)

but CANNOT have no consecutive 1s if there is replacement but no rearrangement
(because there are consecutive 1s in the original list).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A binary string and a positive integer are entered on the command-line.

=end comment
#===============================================================================

use Test;

subset BinStr of Str where / ^ <[ 0 1 ]>+ $ /;
subset Bin    of Int where 0 | 1;
subset Pos    of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 304, Task #1: Arrange Binary (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BinStr:D $digits,          #= A non-empty string of binary digits
    Pos:D    $n                #= A positive integer
)
#===============================================================================
{
    my Bin @digits = $digits.split( '', :skip-empty ).map: { .Int };

    "Input: \@digits = (%s), \$n = %d\n".printf: @digits.join( ', ' ), $n;

    my Bool ($can-rearrange, $can-replace) = arrange( @digits, $n );

    'Output'.put;
    "  Can rearrange: %s\n".printf: $can-rearrange ?? 'true' !! 'false';
    "  Can replace:   %s\n".printf: $can-replace   ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub arrange( List:D[Bin:D] $digits, Pos:D $n --> List:D[Bool:D, Bool:D] )
#-------------------------------------------------------------------------------
{
    my UInt $ones  = 0;
            $ones += $_ for @$digits;
    my UInt $zeros = $digits.elems - $ones;

    my Bool $can-rearrange = ($ones + $n) - ($zeros - $n) <= 1;
    my Bool $can-replace   =  $can-rearrange;

    if $can-replace
    {
        my BinStr $digit-str = $digits.join: '', :skip-empty;
        $can-replace = ($digit-str ~~ / 11 /) ?? False
                                              !! replace( $digit-str, $n );
    }

    return $can-rearrange, $can-replace;
}

#-------------------------------------------------------------------------------
sub replace( BinStr:D $digits is rw, Pos:D $n --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $n-left = $n;

    --$n-left if $digits ~~ / ^ 0 /;

    if $n-left > 0
    {
        --$n-left if $digits ~~ / 0 $ /;

        while $n-left > 0
        {
            $digits ~~ s/ 000 /010/ or last;
            --$n-left;
        }
    }

    return $n-left == 0;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $digit-str, $n, $exp-rearrange, $exp-replace) =
                $line.split: / \| /;

        for     $test-name, $digit-str, $n, $exp-rearrange, $exp-replace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bin @digits = $digit-str.split( '', :skip-empty ).map: { .Int };

        my Bool ($can-rearrange, $can-replace) = arrange( @digits, $n.Int );

        my Str $can-rearrange-str = $can-rearrange ?? 'true' !! 'false';
        my Str $can-replace-str   = $can-replace   ?? 'true' !! 'false';

        is $can-rearrange-str, $exp-rearrange, "$test-name: rearrange";
        is $can-replace-str,   $exp-replace,   "$test-name: replace";
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
        Example 1|10001      |1|true |true
        Example 2|10001      |2|false|false
        Groups 1 |11100000011|1|true |false
        Groups 2 |1000010001 |2|true |true
        Groups 3 |1000001    |2|true |true
        END
}

################################################################################
