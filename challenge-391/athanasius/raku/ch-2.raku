use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 391
=========================

TASK #2
-------
*Arrange Box*

Submitted by: Mohammad Sajid Anwar

You are given an array of box dimensions.

Write a script to determine the maximum number of these boxes that can fit
inside each other in a single stack. For a box to fit inside another, it must be
smaller in both dimensions.

Example 1

  Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
  Output: 4

  Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
  Extract heights: [3, 4, 5, 8]
  [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]

Example 2

  Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
  Output: 3

  Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
  Extract heights: (3, 6, 5, 3, 7)
  [2, 3] -> [4, 5] -> [6, 7]

Example 3

  Input: @boxes = ([5, 5], [5, 5], [5, 5])
  Output: 1

  Sort by width ascending: ([5, 5], [5, 5], [5, 5])
  Extract heights: (5, 5, 5)
  [5, 5]

Example 4

  Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
  Output: 4

  Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
  Extract heights: (100, 200, 300, 400, 50)
  [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]

Example 5

  Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
  Output: 3

  Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
  Extract heights: (20, 18, 10, 25, 30)
  [15, 10] -> [16, 25] -> [20, 30]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Box dimensions are positive integers greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings comprising box dimension pairs (width, height) is entered
   on the command-line. Each dimension must be an integer greater than zero.
   Within each pair, width and height are separated either by a comma (optional-
   ly followed by whitespace), or by whitespace alone.
3. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (viz., the maximum number of boxes that can be stacked together) is
   supplemented with details of the boxes (smallest to largest) in the biggest
   stack. These details are as shown in the final line of each Example.

=end comment
#===============================================================================

use Test;

my regex RxDims { ^ $<width> = [ \d+ ] [ \, \s* || \s+ ] $<height> = [ \d+ ] $ }

subset Box  of List where (UInt, UInt);
subset Dims of Str  where { / <RxDims> / };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 391, Task #2: Arrange Box (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| List of +ve integer box dimensions; e.g., "1, 2" 3,4 "5 6"

    *@dims where { .all ~~ Dims:D },

    Bool :v(:$verbose)                #= Display the boxes in the largest stack?
)
#===============================================================================
{
    my Box @boxes = parse-box-dims( @dims );

    "Input:  \@boxes = (%s)\n".printf: print-boxes( @boxes, ', ' );

    my Box @stack = stack-boxes( @boxes );

    "Output: %d\n".printf: @stack.elems;

    "\n%s\n".printf: print-boxes( @stack, ' -> ' )
        if $verbose && @stack.elems > 0;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub stack-boxes( List:D[Box:D] $boxes --> List:D[Box:D] )
#-------------------------------------------------------------------------------
{
    return () if $boxes.elems == 0;

    my Array[UInt] %w2h{UInt};               # Width => [heights]

    %w2h{ $_[0] }.push: $_[1]                            for @$boxes;
    %w2h{ $_ } = Array[UInt].new: %w2h{ $_ }.sort.squish for %w2h.keys;

    my UInt @widths = %w2h.keys.sort;
    my UInt $width  = @widths.shift;
    my Box  @stack;
            @stack.push: [ $width, %w2h{ $width }[0] ];
    my Box  @max-stack = @stack;

    L-OUTER:
    for @widths -> UInt $width
    {
        my UInt $prev-height = @stack[ *-1 ][1];

        for %w2h{ $width }<> -> UInt $height
        {
            if $height > $prev-height
            {
                @stack.push: [ $width, $height ];
                next L-OUTER;
            }
        }

        @max-stack = @stack if @stack.elems > @max-stack.elems;
        @stack     = ();
        @stack.push: [ $width, %w2h{ $width }[0] ];
    }

    @max-stack = @stack if @stack.elems > @max-stack.elems;

    return @max-stack;
}

#-------------------------------------------------------------------------------
sub parse-box-dims( List:D[Dims:D] $dims --> List:D[Box:D] )
#-------------------------------------------------------------------------------
{
    my Box @boxes;

    for @$dims -> Str $dim
    {
        $dim ~~ &RxDims;

        my Str $width  = ~$<width>;
        my Str $height = ~$<height>;

        +$width  ~~ UInt:D && $width.Int  > 0
            or error( qq[Invalid width "$width"] );

        +$height ~~ UInt:D && $height.Int > 0
            or error( qq[Invalid height "$height"] );

        @boxes.push: Array[UInt].new: $width.Int, $height.Int;
    }

    return @boxes;
}

#-------------------------------------------------------------------------------
sub print-boxes( List:D[Box:D] $boxes, Str:D $join --> Str:D )
#-------------------------------------------------------------------------------
{
    return $boxes.map( { '[' ~ $_[0] ~ ', ' ~ $_[1] ~ ']' } ).join: $join;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $expected,  @dims) = $line.split: '|';

        for     $test-name, $expected, |@dims
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Box  @boxes     = parse-box-dims( @dims );
        my UInt $max-stack = stack-boxes( @boxes ).elems;

        is $max-stack, $expected.Int, $test-name;
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
        Example 1|4| 1   3| 3   5| 6   8| 2  4
        Example 2|3| 4   5| 4   6| 6   7| 2  3| 4   3
        Example 3|1| 5   5| 5   5| 5   5
        Example 4|4| 2 100| 3 200| 4 300| 5 50| 5 400
        Example 5|3|10  20|15  10|20  30|12 18|16  25
        One box  |1|42  17
        No boxes |0
        2nd stack|4| 1   1| 2   2| 3   3| 4  2| 5   3|6 4|7 5|8 1
        END
}

################################################################################
