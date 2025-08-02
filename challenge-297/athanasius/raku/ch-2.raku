use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 297
=========================

TASK #2
-------
*Semi-Ordered Permutation*

Submitted by: Mohammad Sajid Anwar

You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a
semi-ordered permutation.

  A permutation is a sequence of integers from 1 to n of length n containing
  each number exactly once.
  A permutation is called semi-ordered if the first number is 1 and the last
  number equals n.

You are ONLY allowed to pick adjacent elements and swap them.

Example 1

  Input: @ints = (2, 1, 4, 3)
  Output: 2

  Swap 2 <=> 1 => (1, 2, 4, 3)
  Swap 4 <=> 3 => (1, 2, 3, 4)

Example 2

  Input: @ints = (2, 4, 1, 3)
  Output: 3

  Swap 4 <=> 1 => (2, 1, 4, 3)
  Swap 2 <=> 1 => (1, 2, 4, 3)
  Swap 4 <=> 3 => (1, 2, 3, 4)

Example 3

  Input: @ints = (1, 3, 2, 4, 5)
  Output: 0

  Already a semi-ordered permutation.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A permutation of integers 1 to n is entered on the command-line.
3. If VERBOSE is set to True, the output is followed by details of the swaps
   required.

Algorithm
---------
To produce a semi-ordered permutation, the lowest integer (1) must be moved to
the beginning of the list, and the highest integer (n) must be moved to the end
of the list.

Let the initial indices of 1 and n be i and j, respectively. Then, since moves
are accomplished by swapping adjacent elements, it will require (i - 0) = i
swaps to move 1 to the beginning. Likewise, it will require ((n - 1) - j) swaps
to move n to the end. So the minimum number of swaps needed is (i + n - j - 1). 

However, if n is initially at a lower index than 1, then moving 1 to the left
will also accomplish one of the swaps required to move n to the right; in which
case, the minimum number of swaps needed is (i + n - j - 2).

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 297, Task #2: Semi-Ordered Permutation (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A permutation of integers 1 to n

    *@ints where { .elems > 0 && .all ~~ Pos:D && is-permutation( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Str   @swaps;
    my UInt  $min-swaps = find-min-swaps( @ints, VERBOSE, @swaps );

    "Output: $min-swaps".put;

    if VERBOSE && $min-swaps > 0
    {
        put();
       .put for @swaps;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-swaps
(
    List:D[Pos:D] $ints,
    Bool:D        $verbose = False,
    List:_[Str:D] $swaps?
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my UInt $min-idx   =  $ints.first: * == $ints.min, :k;
    my UInt $max-idx   =  $ints.first: * == $ints.max, :k;
    my UInt $min-swaps =  $min-idx + $ints.end - $max-idx;
          --$min-swaps if $max-idx < $min-idx;

    if $verbose && $swaps.defined
    {
        my UInt $listed-swaps = list-swaps( $ints, $swaps );

        $min-swaps == $listed-swaps
            or die "Listed swaps ($listed-swaps) !== min swaps ($min-swaps)";
    }

    return $min-swaps;
}

#-------------------------------------------------------------------------------
sub list-swaps( List:D[Pos:D] $ints, List:D[Str:D] $swaps --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $min-swaps = 0;
    my UInt $min-idx   = $ints.first: * == $ints.min, :k;
    my Pos  @perm      = @$ints;

    for (1 .. $min-idx).reverse -> UInt $i
    {
        @perm[ $i, $i - 1 ] = @perm[ $i - 1, $i ];

        $swaps.push: "Swap %d <=> %d => (%s)".sprintf:
            @perm[ $i ], @perm[ $i - 1 ], @perm.join: ', ';

        ++$min-swaps;
    }

    my UInt $max-idx = @perm.first: * == @perm.max, :k;

    for $max-idx .. @perm.end - 1 -> UInt $j
    {
        @perm[ $j, $j + 1 ] = @perm[ $j + 1, $j ];

        $swaps.push: "Swap %d <=> %d => (%s)".sprintf:
            @perm[ $j + 1 ], @perm[ $j ], @perm.join: ', ';

        ++$min-swaps;
    }

    return $min-swaps;
}

#-------------------------------------------------------------------------------
sub is-permutation( List:D[Pos:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Pos $n      = $ints.max;
    my Pos @sorted = $ints.sort;

    return @sorted cmp (1 .. $n) == Order::Same;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos  @ints  = $ints-str.split( / \s+ /, :skip-empty).map: { .Int };
        my UInt $swaps = find-min-swaps( @ints );

        is $swaps, $expected.Int, $test-name;
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
        Example 1|2 1 4 3  |2
        Example 2|2 4 1 3  |3
        Example 3|1 3 2 4 5|0
        END
}

################################################################################
