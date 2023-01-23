use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 200
=========================

TASK #1
-------
*Arithmetic Slices*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out all Arithmetic Slices for the given array of
integers.


    An integer array is called arithmetic if it has at least 3 elements and the
    differences between any three consecutive elements are the same.


Example 1

  Input: @array = (1,2,3,4)
  Output: (1,2,3), (2,3,4), (1,2,3,4)

Example 2

  Input: @array = (2)
  Output: () as no slice found.

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
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

Output Order
------------
As per Example 1, the slices are ordered by increasing size; slices of the same
size are preserved in the order in which they were found (scanning the array by
increasing indices). Note that the simple statement:

    @slices.= sort: { $^a.elems <=> $^b.elems };

is sufficient here because sorting in Raku is stable [1].

Note
----
In the case where the difference between consecutive elements is zero, the same
slice may appear multiple times in the output. For example, an input array of
(4,4,4,4) produces the output (4,4,4), (4,4,4), (4,4,4,4). I assume this is the
desired result.

Reference
---------
[1] https://docs.raku.org/syntax/stable%20sort#:~:text=Computer%20scientists%20
    call%20this%20a,the%20number%20of%20matches%20won

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 200, Task #1: Arithmetic Slices (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@array where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ',';

    my Array[Int] @slices = find-arithmetic-slices( @array );

    "Output: %s\n".printf: format-slices( @slices );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-arithmetic-slices( List:D[Int:D] $array --> List:D[List:D[Int:D]] )
#------------------------------------------------------------------------------
{
    my Array[Int] @slices;

    for 0 .. $array.end - 2 -> UInt $i
    {
        my Int $gap = $array[ $i + 1 ] - $array[ $i ];

        L-INNER:
        for $i + 2 .. $array.end -> UInt $j
        {
            if $array[ $j ] - $array[ $j - 1 ] == $gap
            {
                @slices.push: Array[Int].new: $array[ $i .. $j ];
            }
            else
            {
                last L-INNER;
            }
        }
    }

    @slices.= sort: { $^a.elems <=> $^b.elems };   # Raku sorting is stable [1]

    return @slices;
}

#------------------------------------------------------------------------------
sub format-slices( List:D[List:D[Int:D]] $slices --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $gist = '()';

    if $slices.elems > 0
    {
        $gist = $slices.map( { '(' ~ @$_.join( ',' ) ~ ')' } ).join: ', ';
    }

    return $gist;
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

        $input    ~~ s/ ^ \s* (.+?) \s* $ /$0/;               # Trim whitespace
        $expected ~~ s/ ^ \s* (.+?) \s* $ /$0/;
        $expected ~~ s:g/ \s+ / /;

        my Int        @array  = $input.split( / \, \s* / ).map: { .Int };
        my Array[Int] @slices = find-arithmetic-slices( @array );
        my Str        $got    = format-slices( @slices );

        is $got, $expected, $test-name;
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
        Example 1 | 1,2,3,4         |(1,2,3), (2,3,4), (1,2,3,4)
        Example 2 | 2               |()
        Evens     | 1,2,4,6,8,9     |(2,4,6), (4,6,8), (2,4,6,8)
        Odds      |-1,1,3,4,5,7,9,10|(-1,1,3), (3,4,5), (5,7,9)
        Decreasing|10,7,4,3,2,1     |(10,7,4), (4,3,2), (3,2,1), (4,3,2,1)
        Up & down |-1,1,3,2,1,0     |(-1,1,3), (3,2,1), (2,1,0), (3,2,1,0)
        Unchanging| 0,42,42,42,42,17|(42,42,42), (42,42,42), (42,42,42,42)
        END
}

###############################################################################
