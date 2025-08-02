use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 327
=========================

TASK #2
-------
*MAD*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference
(MAD) of any two elements.

Example 1

  Input: @ints = (4, 1, 2, 3)
  Output: [1,2], [2,3], [3,4]

  The minimum absolute difference is 1.
  Pairs with MAD: [1,2], [2,3], [3,4]

Example 2

  Input: @ints = (1, 3, 7, 11, 15)
  Output: [1,3]

Example 3

  Input: @ints = (1, 5, 3, 8)
  Output: [1,3], [3,5]

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
2. A non-empty list of distinct integers is entered on the command-line.
3. If the first integer in the list is negative, it must be preceded by "--" to
   signal that it is not a command-line flag.

Note
----
Since the input integers are distinct, the smallest possible MAD is 1.

=end comment
#===============================================================================

use Test;

subset IntPair of List where (Int, Int);
subset Pos     of Int  where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 327, Task #2: MAD (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of distinct integers

    *@ints where { .elems > 0 && .all ~~ Int:D && distinct( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my IntPair @mad-pairs = find-MAD-pairs( @ints );

    "Output: %s\n".printf:
          @mad-pairs.map( { '[%d,%d]'.sprintf: @$_ } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-MAD-pairs( List:D[Int:D] $ints --> List:D[IntPair:D] )
#-------------------------------------------------------------------------------
{
    my Array[IntPair] %ab-diff{Pos};

    my Int @sorted = $ints.sort;

    for 0 .. @sorted.end - 1 -> UInt $i
    {
        my Int $lhs  = @sorted[ $i     ];
        my Int $rhs  = @sorted[ $i + 1 ];
        my Pos $diff = $rhs - $lhs;

        %ab-diff{ $diff }.push: [ +$lhs, +$rhs ];
    }

    my Pos $mad = %ab-diff.keys.min;

    return |%ab-diff{ $mad };
}

#-------------------------------------------------------------------------------
sub distinct( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Pos %count{Int};

    for @$ints
    {
        return False if ++%count{ $_ } > 1;
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
        my Str ($test-name, $ints-str, @exp-strs) = $line.split: / \| /;

        for     $test-name, $ints-str, @exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int     @ints      = $ints-str.split( / \s+ /, :skip-empty )
                                         .map: { .Int };
        my IntPair @mad-pairs = find-MAD-pairs( @ints );
        my IntPair @expected;

        for @exp-strs -> Str $exp-pair
        {
            @expected.push:   [ $exp-pair.split( / \s+ /, :skip-empty )
                                         .map: { .Int } ];
        }

        is-deeply @mad-pairs, @expected, $test-name;
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
        Example 1|4 1 2  3   |1 2|2 3|3 4
        Example 2|1 3 7 11 15|1 3
        Example 3|1 5 3  8   |1 3|3 5
        END
}

################################################################################
