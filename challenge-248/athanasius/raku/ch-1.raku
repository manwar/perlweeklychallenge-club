use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 248
=========================

TASK #1
-------
*Shortest Distance*

Submitted by: Mohammad S Anwar

You are given a string and a character in the given string.

Write a script to return an array of integers of size same as length of the
given string such that:

  distance[i] is the distance from index i to the closest occurence of
  the given character in the given string.

  The distance between two indices i and j is abs(i - j).

Example 1

  Input: $str = "loveleetcode", $char = "e"
  Output: (3,2,1,0,1,0,0,1,2,2,1,0)

  The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
  The closest occurrence of 'e' for index 0 is at index 3, so the distance is
  abs(0 - 3) = 3.
  The closest occurrence of 'e' for index 1 is at index 3, so the distance is
  abs(1 - 3) = 2.
  For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
  but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
  The closest occurrence of 'e' for index 8 is at index 6, so the distance is
  abs(8 - 6) = 2.

Example 2

  Input: $str = "aaab", $char = "b"
  Output: (3,2,1,0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Algorithm
---------
1. Create an array @min-dist of shortest distances, initially all empty.
2. Assign 0 to each element of @min-dist corresponding to the target character.
3. Assign 1 to each *empty* element of @min-dist that is immediately adjacent to
   an element containing 0.
4. Assign 2 to each *empty* element of @min-dist that is immediately adjacent to
   an element containing 1.
5. Repeat for 3, 4, 5, ... until no elements of @min-dist are empty.

Note: this algorithm does not require any measurement of distances.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 248, Task #1: Shortest Distance (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str  where { .chars >= 1 },     #= A string of one or more characters
    Str:D $char where { .chars == 1 && $str ~~ / $char / }
                                           #= A character in the given string
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$char = "$char"].put;

    my UInt @min-dist = find-shortest-distances( $str, $char );

    "Output: (%s)\n".printf: @min-dist.join: ',';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-shortest-distances
(
    Str:D $str  where { .chars >= 1 },     #= A string of one or more characters
    Str:D $char where { .chars == 1 && $str ~~ / $char / }
                                           #= A character in the given string
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my Str  @str-char = $str.split: '', :skip-empty;
    my UInt @min-dist = Int xx @str-char.elems;

    for 0 .. @str-char.end -> UInt $i
    {
        @min-dist[ $i ] = 0 if @str-char[ $i ] eq $char;
    }

    my UInt $target = 0;

    until @min-dist.all.defined
    {
        for 0 .. @str-char.end -> UInt $i
        {
            next unless @min-dist[ $i ].defined && $target == @min-dist[ $i ];

            @min-dist[ $i - 1 ] = $target + 1
                if $i > 0             && !@min-dist[ $i - 1 ].defined;

            @min-dist[ $i + 1 ] = $target + 1
                if $i < @str-char.end && !@min-dist[ $i + 1 ].defined;
        }

        ++$target;
    }

    return @min-dist;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $char, $expected-str) = $line.split: / \| /;

        for     $test-name, $str, $char, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @min-dist = find-shortest-distances( $str, $char );
        my UInt @expected = $expected-str.split( / \s+ / ).map: { .Int };

        is-deeply @min-dist, @expected, $test-name;
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
        Example 1|loveleetcode|e|3 2 1 0 1 0 0 1 2 2 1 0
        Example 2|aaab        |b|3 2 1 0
        END
}

################################################################################
