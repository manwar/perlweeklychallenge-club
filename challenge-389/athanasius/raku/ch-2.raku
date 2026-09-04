use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 389
=========================

TASK #2
-------
*ZigZag Subarray*

Submitted by: Roger Bell_West

You are given an array of integers.

Write a script to find the length of the longest contiguous subarray where the
numbers alternate between strictly increasing and strictly decreasing (a ZigZag
pattern).

  A sequence of numbers $A = [a0, a1, …, ak]$ with length $k >= 1 is considered
  a ZigZag sequence if every adjacent pair alternates direction:

  a_0 < a_1 > a_2 < a_3 > ...
  OR
  a_0 > a_1 < a_2 > a_3 < ...

NOTE: A single element (length 1) or any two distinct elements (length 2) are automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5) break the pattern.

Example 1

  Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
  Output: 5

  ZigZag subarray: (4, 2, 10, 7, 8)

Example 2

  Input: @nums = (1, 7, 4, 9, 2, 5)
  Output: 6

  ZigZag subarray: (1, 7, 4, 9, 2, 5)

Example 3

  Input: @nums = (1, 2, 3, 4, 5)
  Output: 2

  ZigZag subarray: (1, 2)

Example 4

  Input: @nums = (4, 4, 4)
  Output: 1

Example 5

  Input: @nums = (10, 20, 15, 12, 18)
  Output: 3

  ZigZag subarray: (10, 20, 15)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.
4. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (the length of the longest zigzag subarray) is supplemented with the
   contents of that subarray, as shown in Examples 1, 2, 3, and 5.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 388, Task #2: ZigZag Subarray (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@nums where { .elems > 0 && .all ~~ Int:D },

    Bool :v(:$verbose)         #= Display the longest zigzag subarray?
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';

    my Int @zigzag = find-longest-zigzag( @nums );

    "Output: %d\n".printf: @zigzag.elems;

    "\nZigZag subarray: (%s)\n".printf: @zigzag.join: ', ' if $verbose;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-longest-zigzag
(
    List:D[Int:D] $nums where { .elems > 0 }
--> List:D[Int:D]
)
#-------------------------------------------------------------------------------
{
    my Int  @longest       = $nums[0];
    my UInt $min-first-idx = $nums.end;
    my Str  $string        = 'S';

    for 0 .. $nums.end - 1 -> UInt $i
    {
        my Int $lhs = $nums[$i    ];
        my Int $rhs = $nums[$i + 1];

        $string ~= ($lhs > $rhs) ?? 'D' !! ($lhs == $rhs) ?? 'E' !! 'U';
    }

    if $string ~~ / ^ (.*?) ( . <-[E]> ) /
    {
        my UInt $i = (~$0).chars;
        @longest   = $nums[$i, $i + 1];
    }

    for rx/ . [ DU ]+ D? /, rx/ . [ UD ]+ U? / -> Regex $re
    {
        for $string ~~ m:g/ ^ (.*?) (<$re>) / -> Match $match
        {
            my Str ($m0, $m1)  = ~« $match.list;
            my UInt $first-idx = $m0.chars;
            my UInt $match-len = $m1.chars;
            my UInt $max-len   = @longest.elems;

            if ($match-len >  $max-len ||
               ($match-len == $max-len && $min-first-idx > $first-idx))
            {
                my UInt $last-idx = $first-idx + $match-len - 1;
                @longest          = $nums[$first-idx .. $last-idx];
                $min-first-idx    = $first-idx;
            }
        }
    }

    return @longest;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, $exp-len, $exp-z-str) = $line.split: '|';

        for     $test-name, $nums-str, $exp-len, $exp-z-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @nums   = $nums-str\.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @zigzag = find-longest-zigzag( @nums );
        my Int @exp-zz = $exp-z-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is        @zigzag.elems, $exp-len.Int, "$test-name: length";
        is-deeply @zigzag,       @exp-zz,      "$test-name: subarray";
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
        Example 1| 9  4  2 10  7 8 8 1 9|5| 4  2 10 7 8
        Example 2| 1  7  4  9  2 5      |6| 1  7  4 9 2 5
        Example 3| 1  2  3  4  5        |2| 1  2
        Example 4| 4  4  4              |1| 4
        Example 5|10 20 15 12 18        |3|10 20 15
        END
}

################################################################################
