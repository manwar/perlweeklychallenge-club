use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 201
=========================

TASK #1
-------
*Missing Numbers*

Submitted by: Mohammad S Anwar

You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n is
the array size.

Example 1

  Input: @array = (0,1,3)
  Output: 2

  The array size i.e. total element count is 3, so the range is 0..3.
  The missing number is 2 in the given array.

Example 2

  Input: @array = (0,1)
  Output: 2

  The array size is 2, therefore the range is 0..2.
  The missing number is 2.

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

Assumption
----------
Numbers in the input array are integers.

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 201, Task #1: Missing Numbers (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more unique integers

    *@array where { .elems >= 1 && .all ~~ Int:D && is-unique( @array ) }
)
#==============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ',';

    my Int @missing = find-missing-numbers( @array );

    "Output: (%s)\n".printf: @missing.join: ',';
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-missing-numbers( List:D[Int:D] $array --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my UInt $n = $array.elems;
    my Int  @missing;

    L-OUTER:
    for 0 .. $n -> UInt $m
    {
        for 0 .. $array.end -> UInt $i
        {
            next L-OUTER if $array[ $i ] == $m;
        }

        @missing.push: $m;
    }

    return @missing;
}

#------------------------------------------------------------------------------
sub is-unique( List:D[Int:D] $array --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt %element-counts{Int};

    for @$array -> Int $element
    {
        return False if ++%element-counts{ $element } > 1;
    }

    return True;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my Int @array   = $input.split( / \, \s* / ).map: { .Int };
        my Int @missing = find-missing-numbers( @array );
        my Str $got     = @missing.join: ',';

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
        Example 1| 0, 1, 3          |2
        Example 2| 0, 1             |2
        Multi    | 0, 1, 3, 5, 9, 10|2,4,6
        Negatives|-4,-3,-5, 4       |0,1,2,3
        Single   | 0                |1
        Evens    | 1, 3, 5, 7       |0,2,4
        END
}

###############################################################################
