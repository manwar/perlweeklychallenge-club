use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 338
=========================

TASK #2
-------
*Max Distance*

Submitted by: Mohammad Sajid Anwar

You are given two integer arrays, @arr1 and @arr2.

Write a script to find the maximum difference between any pair of values from
both arrays.

Example 1

  Input: @arr1 = (4, 5, 7)
         @arr2 = (9, 1, 3, 4)
  Output: 6

  With element $arr1[0] = 4
  | 4 - 9 | = 5
  | 4 - 1 | = 3
  | 4 - 3 | = 1
  | 4 - 4 | = 0
  max distance = 5

  With element $arr1[1] = 5
  | 5 - 9 | = 4
  | 5 - 1 | = 4
  | 5 - 3 | = 2
  | 5 - 4 | = 1
  max distance = 4

  With element $arr1[2] = 7
  | 7 - 9 | = 2
  | 7 - 1 | = 6
  | 7 - 3 | = 4
  | 7 - 4 | = 4
  max distance = 6

  max (5, 6, 6) = 6

Example 2

  Input: @arr1 = (2, 3, 5, 4)
         @arr2 = (3, 2, 5, 5, 8, 7)
  Output: 6

  With element $arr1[0] = 2
  | 2 - 3 | = 1
  | 2 - 2 | = 0
  | 2 - 5 | = 3
  | 2 - 5 | = 3
  | 2 - 8 | = 6
  | 2 - 7 | = 5
  max distance = 6

  With element $arr1[1] = 3
  | 3 - 3 | = 0
  | 3 - 2 | = 1
  | 3 - 5 | = 2
  | 3 - 5 | = 2
  | 3 - 8 | = 5
  | 3 - 7 | = 4
  max distance = 5

  With element $arr1[2] = 5
  | 5 - 3 | = 2
  | 5 - 2 | = 3
  | 5 - 5 | = 0
  | 5 - 5 | = 0
  | 5 - 8 | = 3
  | 5 - 7 | = 2
  max distance = 3

  With element $arr1[3] = 4
  | 4 - 3 | = 1
  | 4 - 2 | = 2
  | 4 - 5 | = 1
  | 4 - 5 | = 1
  | 4 - 8 | = 4
  | 4 - 7 | = 3
  max distance = 4

  max (5, 6, 3, 4) = 6

Example 3

  Input: @arr1 = (2, 1, 11, 3)
         @arr2 = (2, 5, 10, 2)
  Output: 9

  With element $arr1[0] = 2
  | 2 - 2  | = 0
  | 2 - 5  | = 3
  | 2 - 10 | = 8
  | 2 - 2  | = 0
  max distance = 8

  With element $arr1[1] = 1
  | 1 - 2  | = 1
  | 1 - 5  | = 4
  | 1 - 10 | = 9
  | 1 - 2  | = 1
  max distance = 9

  With element $arr1[2] = 11
  | 11 - 2  | = 9
  | 11 - 5  | = 6
  | 11 - 10 | = 1
  | 11 - 2  | = 9
  max distance = 9

  With element $arr1[3] = 3
  | 3 - 2  | = 1
  | 3 - 5  | = 2
  | 3 - 10 | = 7
  | 3 - 2  | = 1
  max distance = 7

  max (8, 9, 9, 7) = 9

Example 4

  Input: @arr1 = (1, 2, 3)
         @arr2 = (3, 2, 1)
  Output: 2

  With element $arr1[0] = 1
  | 1 - 3 | = 2
  | 1 - 2 | = 1
  | 1 - 1 | = 0
  max distance = 2

  With element $arr1[1] = 2
  | 2 - 3 | = 1
  | 2 - 2 | = 0
  | 2 - 1 | = 1
  max distance = 1

  With element $arr1[2] = 3
  | 3 - 3 | = 0
  | 3 - 2 | = 1
  | 3 - 1 | = 2
  max distance = 2

  max (2, 1, 2) = 2

Example 5

  Input: @arr1 = (1, 0, 2, 3)
         @arr2 = (5, 0)
  Output: 5

  With element $arr1[0] = 1
  | 1 - 5 | = 4
  | 1 - 0 | = 1
  max distance = 4

  With element $arr1[1] = 0
  | 0 - 5 | = 5
  | 0 - 0 | = 0
  max distance = 5

  With element $arr1[2] = 2
  | 2 - 5 | = 3
  | 2 - 0 | = 2
  max distance = 3

  With element $arr1[3] = 3
  | 3 - 5 | = 2
  | 3 - 0 | = 3
  max distance = 3

  max (4, 5, 3, 3) = 5

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
2. Two strings are entered on the command-line. Each string contains a list of
   integers, separated by whitespace.
3. If the first integer in the first input string is negative, then either:
       (i) it must be preceded by whitespace within the string
   or (ii) the first string must be preceded by "--"
   to indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 338, Task #2: Max Distance (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $arr1,                   #= First  list of integers
    Str:D $arr2,                   #= Second list of integers
)
#===============================================================================
{
    my Int (@arr1, @arr2);

    for $arr1.split: / \s+ /, :skip-empty -> Str $str
    {
        +$str ~~ Int or error( qq["$str" is not a valid integer] );
        @arr1.push: +$str;
    }

    for $arr2.split: / \s+ /, :skip-empty -> Str $str
    {
        +$str ~~ Int or error( qq["$str" is not a valid integer] );
        @arr2.push: +$str;
    }

    "Input:  \@arr1 = (%s)\n".printf: @arr1.join: ', ';
    "        \@arr2 = (%s)\n".printf: @arr2.join: ', ';

    my UInt $max-diff = find-max-diff( @arr1, @arr2 );

    "Output: $max-diff".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-diff( List:D[Int:D] $arr1, List:D[Int:D] $arr2 --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-diff = 0;

    for @$arr1 -> Int $i
    {
        for @$arr2 -> Int $j
        {
            my UInt $diff = ($i - $j).abs;

            $max-diff = $diff if $diff > $max-diff;
        }
    }

    return $max-diff;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arr1-str, $arr2-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $arr1-str, $arr2-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @arr1 = $arr1-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int  @arr2 = $arr2-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my UInt $max-diff = find-max-diff( @arr1, @arr2 );

        is $max-diff, $expected.Int, $test-name;
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
        Example 1|4 5  7  |9 1  3 4    |6
        Example 2|2 3  5 4|3 2  5 5 8 7|6
        Example 3|2 1 11 3|2 5 10 2    |9
        Example 4|1 2  3  |3 2  1      |2
        Example 5|1 0  2 3|5 0         |5
        END
}

################################################################################
