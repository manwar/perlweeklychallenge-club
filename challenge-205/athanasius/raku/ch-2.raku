use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 205
=========================

TASK #2
-------
*Maximum XOR*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find the highest value obtained by XORing any two distinct
members of the array.

Example 1

  Input: @array = (1,2,3,4,5,6,7)
  Output: 7

  The maximum result of 1 xor 6 = 7.

Example 2

  Input: @array = (2,4,1,3)
  Output: 7

  The maximum result of 4 xor 3 = 7.

Example 3

  Input: @array = (10,5,7,12,8)
  Output: 15

  The maximum result of 10 xor 5 = 15.

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
2. If $VERBOSE is set to True, then the output is augmented with an explanation
   of how the result was obtained.

Assumption
----------
The elements of the input array are *non-negative* integers only, as shown in
the examples.

=end comment
#==============================================================================

use Test;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 205, Task #2: Maximum XOR (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of non-negative integers, at least 2 distinct

    *@array where { .elems >= 2 && .all ~~ UInt:D }
)
#==============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ',';

    my UInt ($xor, $a, $b) = find-xor-max( @array );

    "Output: $xor".put;

    if $VERBOSE
    {
        my Str  $bin-a = '%b'.sprintf: $a;
        my Str  $bin-b = '%b'.sprintf: $b;
        my UInt $width = ($bin-a.chars, $bin-b.chars).max;

        "\nThe maximum result of %*d xor %*d = %*d\n".printf:
           $width, $a, $width, $b, $width, $xor;

        "             (binary: %0*b xor %0*b = %0*b)\n".printf:
           $width, $a, $width, $b, $width, $xor;
    }
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-xor-max( List:D[UInt:D] $array --> List:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt %freq{UInt};

    ++%freq{ $_ } for @$array;

    my UInt @ordered = %freq.keys.sort;

    @ordered.elems >= 2
        or error( 'The input array does not contain 2 distinct members' );

    my Int   $xor-max = -1;
    my UInt ($a-max, $b-max);

    for 0 .. @ordered.end - 1 -> UInt $i
    {
        my UInt $a = @ordered[ $i ];

        for $i + 1 .. @ordered.end -> UInt $j
        {
            my UInt $b   = @ordered[ $j ];
            my UInt $xor = $a +^ $b;

            if $xor > $xor-max
            {
                $xor-max = $xor;
                $a-max   = $a;
                $b-max   = $b;
            }
        }
    }

    return $xor-max, $a-max, $b-max;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my UInt @array = $input.split( / \, \s* / ).map: { .Int };
        my UInt $got   = (find-xor-max( @array ))[ 0 ];

        is $got, $expected.Int, $test-name;
    }

    done-testing;
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

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 1, 2, 3,  4, 5, 6, 7|7
        Example 2| 2, 4, 1,  3         |7
        Example 3|10, 5, 7, 12, 8      |15
        END
}
###############################################################################
