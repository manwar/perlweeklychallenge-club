use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 189
=========================

TASK #2
-------
*Array Degree*

Submitted by: Mohammad S Anwar

You are given an array of 2 or more non-negative integers.

Write a script to find out the smallest slice, i.e. contiguous subarray of the
original array, having the degree of the given array.

    The degree of an array is the maximum frequency of an element in the array.

Example 1

  Input: @array = (1, 3, 3, 2)
  Output: (3, 3)

  The degree of the given array is 2.
  The possible subarrays having the degree 2 are as below:
  (3, 3)
  (1, 3, 3)
  (3, 3, 2)
  (1, 3, 3, 2)

  And the smallest of all is (3, 3).

Example 2

  Input: @array = (1, 2, 1, 3)
  Output: (1, 2, 1)

Example 3

  Input: @array = (1, 3, 2, 1, 2)
  Output: (2, 1, 2)

Example 4

  Input: @array = (1, 1, 2, 3, 2)
  Output: (1, 1)

Example 5

  Input: @array = (2, 1, 2, 1, 1)
  Output: (1, 2, 1, 1)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
The "smallest" slice is the slice with fewest elements (i.e., the shortest),
regardless of the values of the elements.

When two or more same-length slices satisfy the given criteria, the first-found
slice is given as the solution.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 189, Task #2: Array Degree (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| An array of 2 or more non-negative integers

    *@array where { .elems >= 2 && .all ~~ UInt:D }
)
#==============================================================================
{
    "Input:  @array = (%s)\n".printf: @array.join: ', ';

    my $slice = find-smallest-slice( @array );

    "Output: (%s)\n".printf: $slice.join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-smallest-slice( List:D[UInt:D] $array --> List:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt $degree    = find-degree( $array );
    my UInt @min-slice = @$array;
    my UInt $min-size  = $array.elems;

    for 0 .. $array.end -> UInt $i
    {
        for $i .. $array.end -> UInt $j
        {
            my UInt @slice = $array[ $i .. $j ];
            my UInt $size  = @slice.elems;

            if $size < $min-size
            {
                my UInt $slice-degree = find-degree( @slice );

                if $slice-degree == $degree
                {
                    @min-slice = @slice;
                    $min-size  = $size;
                }
            }
        }
    }

    return @min-slice;
}

#------------------------------------------------------------------------------
sub find-degree( List:D[UInt:D] $array --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt %freq;
          ++%freq{ $_ } for @$array;

    my UInt $max = 0;

    for %freq<>:v -> UInt $freq
    {
        $max = $freq if $freq > $max;
    }

    return $max;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $array, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        my UInt @array = $array.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @slice = find-smallest-slice( @array );

        is @slice.join( ' ' ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,   1 3 3 2,              3 3
        Example 2,   1 2 1 3,              1 2 1
        Example 3,   1 3 2 1 2,            2 1 2
        Example 4,   1 1 2 3 2,            1 1
        Example 5,   2 1 2 1 1,            1 2 1 1
        Whole array, 1 2 3 4 5 1,          1 2 3 4 5 1
        Degree 1,    1 2 3 4 5 6 7 8 9 10, 1
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
