use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 318
=========================

TASK #2
-------
*Reverse Equals*

Submitted by: Roger Bell_West

You are given two arrays of integers, each containing the same elements as the
other.

Write a script to return true if one array can be made to equal the other by
reversing exactly one contiguous subarray.

Example 1

  Input: @source = (3, 2, 1, 4)
         @target = (1, 2, 3, 4)
  Output: true

  Reverse elements: 0-2

Example 2

  Input: @source = (1, 3, 4)
         @target = (4, 1, 3)
  Output: false

Example 3

  Input: @source = (2)
         @target = (2)
  Output: true

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
2. Two strings are entered on the command-line. Each is a whitespace-separated
   list of integers. The second ("target") list contains the same elements as
   the first ("source") list, but not necessarily in the same order.

Notes
-----
1. If the target array is not a permutation of the source array, then of course
   the arrays cannot be made equal by reversing a subarray. So it would make
   sense to simply return "false" in this case. However, as the Task specifies
   that the two arrays contain the same elements, input of two arrays which are
   not permutations of each other is here treated as an error.
2. If the input arrays are empty, there is nothing to be reversed, so there
   cannot be "exactly one" subarray reversed. In this case, "false" is returned.
3. If the two arrays are identical, and of length n, then there are n ways in
   which a subarray of length one can be "reversed" to leave them identical. In
   this case, "reversal" of the subarray from index 0 to 0 (i.e., of the first
   character) is given as the solution.
4. If the arrays differ at exacly one character, no solution is possible.
5. In all other cases, if a solution is possible then the subarray to be
   reversed must extend from the first (left-most) non-identical character to
   the last (right-most) non-identical character.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 318, Task #2: Reverse Equals (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $source,             #= Source string of whitespace-separated integers
    Str:D $target              #= Target string of whitespace-separated integers
)
#===============================================================================
{
    my Int @source = parse-input( $source );
    my Int @target = parse-input( $target );

    @source.sort ~~ @target.sort or error( 'The input list elements differ' );

    "Input:  \@source = (%s)\n".printf: @source.join: ', ';
    "        \@target = (%s)\n".printf: @target.join: ', ';

    my UInt ($start, $end) = reverse-equals( @source, @target );

    if $start.defined && $end.defined
    {
        'Output: true'.put;

        "\nReverse elements: $start-$end".put;
    }
    else
    {
        'Output: false'.put;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-equals
(
    List:D[Int:D] $source,
    List:D[Int:D] $target
--> List:D[UInt,UInt]
)
#-------------------------------------------------------------------------------
{
    return UInt, UInt if $source.elems == 0;
    return 0, 0       if $source ~~ $target;

    my UInt ($start, $end);

    for  0 .. $source.end          -> UInt $i
    {
        $start = $i, last if $source[ $i ] !== $target[ $i ];
    }

    for (0 .. $source.end).reverse -> UInt $j
    {
        $end   = $j, last if $source[ $j ] !== $target[ $j ];
    }

    return $start,  $end
        if $start < $end && $source[ $start .. $end ].reverse ~~
                            $target[ $start .. $end ];

    return UInt, UInt;
}

#-------------------------------------------------------------------------------
sub parse-input( Str:D $str --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @ints;
    my Str @elems = $str.split: / \s+ /, :skip-empty;

    for @elems -> Str $elem
    {
        +$elem ~~ Int or error( qq[Invalid integer "$elem"] );

        @ints.push: +$elem;
    }

    return @ints;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $source-str, $target-str, $start-str, $end-str) =
                $line.split: / \| /;

        for     $test-name, $source-str, $target-str, $start-str, $end-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int   @source       = parse-input( $source-str );
        my Int   @target       = parse-input( $target-str );
        my UInt ($start, $end) = reverse-equals( @source, @target );
        my UInt  $exp-start    = $start-str eq '' ?? UInt !! +$start-str;
        my UInt  $exp-end      = $end-str   eq '' ?? UInt !! +$end-str;

        ok $start ~~ $exp-start && $end ~~ $exp-end, $test-name;
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
        Example 1|3 2 1 4|1 2 3 4|0|2
        Example 2|1 3 4  |4 1 3  | |
        Example 3|2      |2      |0|0
        Empty    |       |       | |
        Same 1   |1 2 3 4|1 2 3 4|0|0
        Same 2   |7 7 7  |7 7 7  |0|0
        Whole    |1 2 3 4|4 3 2 1|0|3
        Left     |1 2 3 4|3 2 1 4|0|2
        Right    |1 2 3 4|1 4 3 2|1|3
        Centre   |1 2 3 4|1 3 2 4|1|2
        END
}

################################################################################
