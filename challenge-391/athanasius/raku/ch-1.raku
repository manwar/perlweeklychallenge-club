use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 391
=========================

TASK #1
-------
*Array Median*

Submitted by: Mohammad Sajid Anwar

You are given two sorted arrays.

Write a script to merge the two given sorted arrays and return the median of the
merged array.

Example 1

  Input: @arr1 = (2), @arr2 = (4)
  Output: 3.0

  Merged array: (2,4)
  Median: (2+4)/2 => 3

Example 2

  Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
  Output: 7.0

  Merged array: (1,2,3,7,8,9,10)
  Length of merged array is 7, the 4th element is 7.

Example 3

  Input: @arr1 = (), @arr2 = (10,20,30,40)
  Output: 25.0

  Merged array: (10,20,30,40)
  Median: (20+30)/2 => 25

Example 4

  Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
  Output: 4.5

  Merged array: (1,2,3,4,5,6,7,100)
  Median: (4+5)/2 => 4.5

Example 5

  Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
  Output: 2.0

  Merged array: (1,2,2,2,2,3)
  Median: (2+2)/2 => 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Elements of the input lists are integers.
2. An input array may be empty (see Example 3); but if both input arrays are
   empty, no median is defined. In this case, the result is displayed as
   "Output: <none>".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings, each containing a sorted list of comma-separated integers, are
   entered on the command-line.
3. If the first element of the first string is negative, the string must be pre-
   ceded by "--" to indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 391, Task #1: Array Median (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $arr1,          #= The first  sorted, comma-separated list of integers
    Str:D $arr2           #= The second sorted, comma-separated list of integers
)
#===============================================================================
{
    my Array[Int] ($array1, $array2) = parse-input( $arr1, $arr2 );

    "Input:  \@arr1 = (%s), \@arr2 = (%s)\n".printf:
              $array1.join( ',' ), $array2.join( ',' );

    my Rat $median     = find-median( $array1, $array2 );
    my Str $median-fmt = $median.defined ?? '%.1f'.sprintf: $median !! '<none>';

    "Output: $median-fmt".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-median( List:D[Int:D] $arr1, List:D[Int:D] $arr2 --> Rat )
#-------------------------------------------------------------------------------
{
    my Rat  $median;
    my Int  @merged  =    |$arr1;
            @merged.push: |$arr2;
            @merged .= sort;
    my UInt $count   = @merged.elems;

    if $count > 0
    {
        my UInt $i = (@merged.end / 2).floor;
        $median    = ($count %% 2) ?? (@merged[$i] + @merged[$i + 1]) / 2
                                   !!  @merged[$i].Rat;
    }

    return $median;
}

#-------------------------------------------------------------------------------
sub parse-input
(
    Str:D $arr1,
    Str:D $arr2
--> List:D[List:D[Int:D],List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    my Int (@arr1, @arr2);

    for $arr1.split: / \, /, :skip-empty -> Str $n
    {
        +$n ~~ Int:D    or error( qq["$n" is not a valid integer] );
        @arr1.push: +$n;
    }

    @arr1 ~~ @arr1.sort or error( '@arr1 is not sorted' );

    for $arr2.split: / \, /, :skip-empty -> Str $n
    {
        +$n ~~ Int:D    or error( qq["$n" is not a valid integer] );
        @arr2.push: +$n;
    }

    @arr2 ~~ @arr2.sort or error( '@arr2 is not sorted' );

    return @arr1, @arr2;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arr1-str, $arr2-str, $exp-str) = $line.split: '|';

        for     $test-name, $arr1-str, $arr2-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Array[Int] ($array1, $array2) = parse-input( $arr1-str, $arr2-str );

        my Rat $median = find-median( $array1, $array2 );

        if $median.defined
        {
            is $median,  $exp-str.Rat, $test-name;
        }
        else
        {
            is '<none>', $exp-str,     $test-name;
        }
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
        Example 1|2    |4            | 3.0
        Example 2|1,2,3|7,8,9,10     | 7.0
        Example 3|     |10,20,30,40  |25.0
        Example 4|100  |1,2,3,4,5,6,7| 4.5
        Example 5|1,2,2|2,2,3        | 2.0
        Empty    |     |             |<none>
        END
}

################################################################################
