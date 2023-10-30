use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 236
=========================

TASK #2
-------
*Array Loops*

Submitted by: Mark Anderson

You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

    To determine a loop: Start at an index and take the number at array[index]
    and then proceed to that index and continue this until you end up at the
    starting index.

Example 1

  Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
  Output: 3

  To determine the 1st loop, start at index 0, the number at that index is 4,
  proceed to index 4, the number at that index is 15, proceed to index 15 and so
  on until you're back at index 0.

  Loops are as below:
  [4 15 1 6 13 5 0]
  [3 8 7 18 9 16 12 17 2]
  [14 11 19 10]

Example 2

  Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
  Output: 6

  Loops are as below:
  [0]
  [1]
  [13 9 14 17 18 15 5 8 2]
  [7 11 4 6 10 16 3]
  [12]
  [19]

Example 3

  Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
  Output: 1

  Loop is as below:
  [9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The contents of the input array are the valid indices for that array (in any
order). Therefore:
1. The minimum array value is 0.
2. For an array of n elements, the maximum array value is (n - 1).
3. Since the array values are unique, each valid index is included in the input
   array exactly once.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True (the default), the output is followed by details of
   the loops found.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 236, Task #2: Array Loops (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of all valid array indices in any order

    *@ints where { .elems > 0 && .all ~~ UInt:D &&
                   .min  == 0 && .max == .end   && .elems == .unique.elems }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ',';

    my Array[UInt] @loops = find-loops( @ints );
    my UInt        $count = @loops.elems;

    "Output: $count".put;

    if VERBOSE
    {
        "\nLoop%s as below:\n".printf: $count == 1 ?? ' is' !! 's are';
        "[%s]\n"\             .printf: .join: ' ' for @loops;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-loops( List:D[UInt:D] $ints --> List:D[List:D[UInt:D]] )
#-------------------------------------------------------------------------------
{
    my Array[UInt] @loops;
    my Bool        @found = False xx $ints.elems;

    for 0 .. $ints.end -> UInt $i
    {
        next if @found[ $i ];

        my UInt $start   = $ints[ $i ];
        @found[ $start ] = True;
        my UInt @loop    = $start;
        my UInt $last    = $start;
        my Int  $next    = -1;

        loop
        {
            $next = $ints[ $last ];

            last if $next == $start;

            @loop.push:       $next;
            @found[ $next ] = True;
            $last           = $next;
        }

        @loops.push: @loop;
    }

    return @loops;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str,  @exp-strs) = $line.split: / \| /;

        for     $test-name, $ints-str, |@exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt        @ints  = $ints-str.split( / \s+ / ).map: { .Int };
        my Array[UInt] @loops = find-loops( @ints );
        my Array[UInt] @expected;

        for @exp-strs -> Str $exp-str
        {
            @expected.push:
                Array[UInt].new: $exp-str.split( / \s+ / ).map: { .Int };
        }

        is-deeply @loops, @expected, $test-name;
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
    my Str $data =q:to/END/;
        Example 1|4  6  3  8 15  0 13 18  7 16 14 19 17  5 11  1 12  2  9 10   \
                 |4 15  1  6 13  5  0| 3  8  7 18  9 16 12 17  2|14 11 19 10
        Example 2|0  1 13  7  6  8 10 11  2 14 16  4 12  9 17  5  3 18 15 19   \
                 |0| 1|13  9 14 17 18 15  5  8  2| 7 11  4  6 10 16  3|12|19
        Example 3|9  8  3 11  5  7 13 19 12  4 14 10 18  2 16  1  0 15  6 17   \
                 |9  4  5  7 19 17 15  1  8 12 18  6 13  2  3 11 10 14 16  0
        END

    $data ~~ s:g/ \\ \n //;

    return $data;
}

################################################################################
