use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 319
=========================

TASK #2
-------
*Minimum Common*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays. If none
found return -1.

Example 1

  Input: @array_1 = (1, 2, 3, 4)
         @array_2 = (3, 4, 5, 6)
  Output: 3

  The common integer in both arrays: 3, 4
  The minimum is 3.

Example 2

  Input: @array_1 = (1, 2, 3)
         @array_2 = (2, 4)
  Output: 2

Example 3

  Input: @array_1 = (1, 2, 3, 4)
         @array_2 = (5, 6, 7, 8)
  Output: -1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Since -1 is returned on failure, it may be inferred that the input is limited to
*unsigned* integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string contains a list of
   whitespace-separated unsigned integers.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 319, Task #2: Minimum Common (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $array_1,    #= First  string of space-separated unsigned integers
    Str:D $array_2     #= Second string of space-separated unsigned integers
)
#===============================================================================
{
    my UInt @array_1 = parse-array( $array_1 );
    my UInt @array_2 = parse-array( $array_2 );

    "Input:  \@array_1 = (%s)\n".printf: @array_1.join: ', ';
    "        \@array_2 = (%s)\n".printf: @array_2.join: ', ';

    my Int $min-common = find-min-common( @array_1, @array_2 );

    "Output: $min-common".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-common
(
    List:D[UInt:D] $array_1,
    List:D[UInt:D] $array_2
--> Int:D
)
#-------------------------------------------------------------------------------
{
    my Set[UInt] $set1   = Set[UInt].new: @$array_1;
    my Set[UInt] $set2   = Set[UInt].new: @$array_2;
    my Set[UInt] $common = $set1 ∩ $set2;

    return $common ≡ ∅ ?? -1 !! $common.keys.min;
}

#-------------------------------------------------------------------------------
sub parse-array( Str:D $str --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @array;
    my Str  @elems = $str.split: / \s+ /, :skip-empty;

    for @elems -> Str $elem
    {
       +$elem ~~ UInt or error( qq["$elem" is not a valid unsigned integer] );

        @array.push: +$elem;
    }

    return @array;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $array_1-str, $array_2-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $array_1-str, $array_2-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @array_1    = parse-array( $array_1-str );
        my UInt @array_2    = parse-array( $array_2-str );
        my Int  $min-common = find-min-common( @array_1, @array_2 );

        is $min-common, $expected.Int, $test-name;
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
        Example 1|1 2 3 4|3 4 5 6| 3
        Example 2|1 2 3  |2 4    | 2
        Example 3|1 2 3 4|5 6 7 8|-1
        END
}

################################################################################
