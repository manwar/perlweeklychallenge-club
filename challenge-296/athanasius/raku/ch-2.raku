use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 296
=========================

TASK #2
-------
*Matchstick Square*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as
in the given array @ints where $ints[ì] is the length of ith stick.

Example 1

  Input: @ints = (1, 2, 2, 2, 1)
  Output: true

  Top: $ints[1] = 2
  Bottom: $ints[2] = 2
  Left: $ints[3] = 2
  Right: $ints[0] and $ints[4] = 2

Example 2

  Input: @ints = (2, 2, 2, 4)
  Output: false

Example 3

  Input: @ints = (2, 2, 2, 2, 4)
  Output: false

Example 4

  Input: @ints = (3, 4, 1, 4, 3, 1)
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
In forming the square, each matchstick must be used exactly once.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of positive (non-zero) integers is entered on the command-
   line.
3. If VERBOSE is set to True, an output of "true" is followed by details of the
   makeup of each side of the square.

Algorithm
---------
Beginning with the longest matchstick and working down to the shortest, each
stick is placed in the first available side, and so on recursively until either
all sides are filled (success) or further progress is impossible. In the latter
case, the algorithm backtracks to the most recent placement, and the next
possible placement is tried. When all possible placements have been tried with-
out success, the algorithm returns failure.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 296, Task #2: Matchstick Square (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive (non-zero) integers

    *@ints where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Array[Pos] @sides;
    my Bool       $result = make-square( @ints, @sides );

    "Output: %s\n".printf: $result ?? 'true' !! 'false';

    if VERBOSE && $result
    {
        "\nTop:    %s\n".printf: @sides[ 0 ].join: ' + ';
          "Bottom: %s\n".printf: @sides[ 1 ].join: ' + '; 
          "Left:   %s\n".printf: @sides[ 2 ].join: ' + ';
          "Right:  %s\n".printf: @sides[ 3 ].join: ' + ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub make-square( List:D[Pos:D] $ints, List:D[List:D[Pos:D]] $sides --> Bool:D )
#-------------------------------------------------------------------------------
{
    $sides.push: Array[Pos].new for 1 .. 4;

    my Bool $result = False;
    my UInt $sum    = [+] @$ints;

    if $sum %% 4
    {
        my Pos $target = ( $sum / 4 ).Int;
        my Pos @sticks = $ints.sort: { $^b cmp $^a };

        if @sticks[ 0 ] <= $target
        {
            $result = add-stick( $sides, @sticks, $target );
        }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub add-stick
(
    List:D[List:D[Pos:D]] $sides,
    List:D[Pos:D]         $sticks,
    Pos:D                 $target
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    if solved( $sides, $target )
    {
        $sticks.elems == 0 or die 'Not all sticks used';

        return True;                         # Base case 1: Solved
    }

    return False if $sticks.elems == 0;      # Base case 2: No more sticks

    my Pos $stick = $sticks.shift;                              # Reductive step

    for get-sides-to-try( $sides, $target, $stick ) -> UInt $i
    {
        $sides[ $i ].push: $stick;

        return True if add-stick( $sides, $sticks, $target );   # Recursive call

        $sides[ $i ].pop;
    }

    return False;                            # Base case 3: No more sides to try
}

#-------------------------------------------------------------------------------
sub get-sides-to-try
(
    List:D[List:D[Pos:D]] $sides,
    Pos:D                 $target,
    Pos:D                 $stick
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt @sides-to-try;

    for 0 .. 3 -> UInt $i
    {
        my UInt $sum  = [+] |$sides[ $i ];
        my UInt $diff = $target - $sum;

        @sides-to-try.push: $i if $stick <= $diff;
    }

    return @sides-to-try;
}

#-------------------------------------------------------------------------------
sub solved( List:D[List:D[Pos:D]] $sides, Pos:D $target --> Bool:D )
#-------------------------------------------------------------------------------
{
    for 0 .. 3 -> UInt $i
    {
        my UInt $sum = [+] |$sides[ $i ];

        return False unless $sum == $target;
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
        my Str ($test-name, $ints-str, @expected-strs) = $line.split: / \| /;

        for     $test-name, $ints-str, @expected-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos        @ints = $ints-str.split( / \s+ /, :skip-empty )\
                                       .map: { .Int };
        my Array[Pos] @sides;

        make-square( @ints, @sides );

        my Array[Pos] @expected = Array[Pos].new xx 4;

        if @expected-strs[ 0 ].chars > 0
        {
            my UInt $i = 0;

            for @expected-strs -> Str $str
            {
                @expected[ $i++ ].push:
                    |$str.split( / \s+ /, :skip-empty ).map: { .Int };
            }
        }

        is-deeply @sides, @expected, $test-name;
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
        Example 1     |1 2 2 2 1                 |2|2|2|1 1
        Example 2     |2 2 2 4                   |
        Example 3     |2 2 2 2 4                 |
        Example 4     |3 4 1 4 3 1               |4|4|3 1|3 1
        No more sticks|6 1 1 5 3 4  4            |
        Doesn't fit   |2   2 3 5 5 10 13 15 26 27|
        Does fit      |1 1 2 3 5 5 10 13 15 26 27|27|26 1|15 10 2|13 5 5 3 1
        END
}

################################################################################
