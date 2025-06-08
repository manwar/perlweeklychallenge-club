use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 324
=========================

TASK #1
-------
*2D Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns using
the given array.

Example 1

  Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
  Output: ([1, 2], [3, 4])

Example 2

  Input: @ints = (1, 2, 3), $r = 1, $c = 3
  Output: ([1, 2, 3])

Example 3

  Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
  Output: ([1], [2], [3], [4])

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Array dimensions $r and $c are non-zero, unsigned integers.
2. The input integers must exactly fit into the $r by $c array; i.e., |@ints| =
   $r * $c.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The desired number of rows and columns are entered as named arguments on the
   command-line, followed by the elements to be used in populating the array.
3. If the first element is a negative integer, it must be preceded by "--" to
   signal that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 324, Task #1: 2D Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D :$r,                #= Number of rows    (integer > 0)
    Pos:D :$c,                #= Number of columns (integer > 0)

    #| Array elements (1+ integers)

    *@ints where { .elems > 0 && .all ~~ Int:D && @ints.elems == $r * $c }
)
#===============================================================================
{
    "Input:  \@ints = (%s), \$r = %d, \$c = %d\n".printf:
        @ints.join( ', ' ), $r, $c;

    my Array[Int] @two-dim = make-array( @ints, $r, $c );

    "Output: (%s)\n".printf: @two-dim.map( { '[' ~ .join( ', ' ) ~ ']' } )
                                     .join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub make-array
(
    List:D[Int:D] $ints,
    Pos:D         $r,
    Pos:D         $c
--> List:D[List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    $ints.elems == $r * $c
        or die 'Mismatch between array dimensions and number of elements';

    my Array[Int] @two-dim;
    my Int        @row = +$ints[ 0 ];

    for 1 .. $ints.end -> UInt $i
    {
        if $i %% $c
        {
            @two-dim.push: @row.clone;

            @row = +$ints[ $i ];
        }
        else
        {
            @row.push: +$ints[ $i ];
        }
    }

    @two-dim.push: @row;

    return @two-dim;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $r, $c, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $r, $c, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int        @ints    = $int-str.split( / \s+ /, :skip-empty )
                                         .map: { .Int };
        my Array[Int] @two-dim = make-array( @ints, $r.Int, $c.Int );
        my Array[Int] @expected;

        for $exp-str.split: / \; /, :skip-empty
        {
            @expected.push: Array[Int].new: .split( / \s+ /, :skip-empty )
                                            .map: { .Int };
        }

        is-deeply @expected, @two-dim, $test-name;
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
        Example 1|1 2 3 4|2|2|1  2; 3 4
        Example 2|1 2 3  |1|3|1  2  3
        Example 3|1 2 3 4|4|1|1; 2; 3; 4
        END
}

################################################################################
