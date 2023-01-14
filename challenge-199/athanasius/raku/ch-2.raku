use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 199
=========================

TASK #2
-------
*Good Triplets*

Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following
conditions:

  a) 0 <= i < j < k <= n (size of given array)
  b) abs(array[i] - array[j]) <= x
  c) abs(array[j] - array[k]) <= y
  d) abs(array[i] - array[k]) <= z

Example 1

  Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
  Output: 4

  Good Triplets are as below:
  (3,0,1) where (i=0, j=1, k=2)
  (3,0,1) where (i=0, j=1, k=3)
  (3,1,1) where (i=0, j=2, k=3)
  (0,1,1) where (i=1, j=2, k=3)

Example 2

  Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
  Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. N.B.: $x, $y, $z must appear on the command line (in that order) BEFORE the
   elements of @array.
3. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.
4. If $VERBOSE is set to a true value, an explanation like that in Example 1 is
   appended to the solution.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;
my Bool constant $VERBOSE     = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 199, Task #2: Good Triplets (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Int:D $x,                           #= An integer
    Int:D $y,                           #= An integer
    Int:D $z,                           #= An integer
    *@array where { .all ~~ Int:D }     #= A list of integers
)
#==============================================================================
{
    "Input:  \@array = (%s) and \$x = %d, \$y = %d, \$z = %d\n".printf:
        @array.join( ',' ), $x, $y, $z;

    my Array[UInt] @triplets = find-good-triplets( $x, $y, $z, @array );

    "Output: %d\n".printf: @triplets.elems;

    give-details( @array, @triplets ) if $VERBOSE;
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-good-triplets
(
    Int:D         $x,
    Int:D         $y,
    Int:D         $z,
    List:D[Int:D] $array
--> List:D[List:D[UInt:D]]
)
#------------------------------------------------------------------------------
{
    my Array[UInt] @triplets;

    for 0 .. $array.end - 2 -> UInt $i
    {
        for $i + 1 .. $array.end - 1 -> UInt $j
        {
            if ($array[ $i ] - $array[ $j ]).abs <= $x
            {
                for $j + 1 .. $array.end -> UInt $k
                {
                    if ($array[ $j ] - $array[ $k ]).abs <= $y &&
                       ($array[ $i ] - $array[ $k ]).abs <= $z
                    {
                        @triplets.push: Array[UInt].new: $i, $j, $k;
                    }
                }
            }
        }
    }

    return @triplets;
}

#------------------------------------------------------------------------------
sub give-details( List:D[Int:D] $array, List:D[List:D[UInt:D]] $triplets )
#------------------------------------------------------------------------------
{
    my UInt $count = $triplets.elems;

    if    $count == 0
    {
        "\nThere are no good triplets in the array".put;
    }
    elsif $count == 1
    {
        "\nThere is 1 good triplet in the array:\n".put;

        "(%s) where (i=%d, j=%d, k=%d)\n".printf:
            $array[ |$triplets[ 0 ] ].join( ',' ), |$triplets[ 0 ];
    }
    else
    {
        "\nThere are $count good triplets in the array:".put;

        "(%s) where (i=%d, j=%d, k=%d)\n".printf:
            $array[ @$_ ].join( ',' ), @$_ for @$triplets;
    }
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
            $line.split: / \| /, $TEST-FIELDS;

        s/ ^ \s* (.+?) \s* $ /$0/                             # Trim whitespace
            for $test-name, $input, $expected;

        my Int ($x, $y, $z, @array) =
            $input.split( / \, /, :skip-empty ).map: { .Int };

        my UInt $got = find-good-triplets( $x, $y, $z, @array ).elems;

        is $got, $expected.Int, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|7,2,3,3,0,1,1,9,7|4
        Example 2|0,0,1,1,1,2,2,3  |0
        Single   |7,2,3,3,0,1      |1
        END
}

###############################################################################
