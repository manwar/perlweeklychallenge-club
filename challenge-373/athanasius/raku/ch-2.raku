use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 373
=========================

TASK #2
-------
*List Division*

Submitted by: Mark Anderson

You are given a list and a non-negative integer.

Write a script to divide the given list into given non-negative integer equal 
parts. Return -1 if the integer is more than the size of the list.

Example 1

  Input: @list = (1,2,3,4,5), $n = 2
  Output: ((1,2,3), (4,5))

  5 / 2 = 2 remainder 1.
  The extra element goes into the first chunk.

Example 2

  Input: @list = (1,2,3,4,5,6), $n = 3
  Output: ((1,2), (3,4), (5,6))

  6 / 3 = 2 remainder 0.

Example 3

  Input: @list = (1,2,3), $n = 2
  Output: ((1,2), (3))

Example 4

  Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
  Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

Example 5

  Input: @list = (1,2,3), $n = 4
  Output: -1

Example 6

  Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
  Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The members of @list are unsigned integers.
2. @list has at least one member.
3. $n is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive (i.e., greater than zero) integer is entered on the command-line,
   followed by a non-empty list of unsigned integers.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

my Bool constant DEBUG = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 373, Task #2: List Division (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $n,   #= Divisor: a positive integer

    #| A non-empty list of unsigned integers

    *@list where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@list = (%s), \$n = %d\n".printf: @list.join( ',' ), $n;

    my Array[Array[UInt]] $division = divide-list( $n, @list );

    if $division.defined
    {
        my @list-strs = $division.map: { '(' ~ join( ',', @$_ ) ~ ')' };

        "Output: (%s)\n".printf: @list-strs.join: ', ';
    }
    else
    {
        'Output: -1'.put;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub divide-list
(
    Pos:D          $n,
    List:D[UInt:D] $list where { .elems > 0 }
--> List:_[List:D[UInt:D]]
)
#-------------------------------------------------------------------------------
{
    my UInt $list-size = $list.elems;

    return Nil if $n > $list-size;

    my Array[UInt] @division;
    my Pos         $quotient  = $list-size div $n;
    my UInt        $remainder = $list-size  %  $n;

    for 1 .. $n -> UInt $i
    {
        my UInt @sublist;

        @sublist.push: $list.shift for 1 .. $quotient;

        if $remainder > 0
        {
            @sublist.push: $list.shift;
            --$remainder;
        }

        @division.push: @sublist;
    }

    if DEBUG
    {
        $remainder      ==  0 or die "\$remainder is $remainder, should be 0";
        $list.elems     ==  0 or die "\$list is not empty";
        @division.elems == $n or die "\@division has { @division.elems } " ~
                                     "elements, should have $n";
    }

    return @division;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list-str, $n,  @exp-strs) = $line.split: '|';

        for     $test-name, $list-str, $n, |@exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @list = $list-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my Array[Array[UInt]] $division = divide-list( $n.Int, @list );

        if $division.defined
        {
            my Array[UInt] @expected = @exp-strs.map:
             { Array[UInt].new: .split( / \s+ /, :skip-empty ).map: { .Int } };

            is-deeply $division, @expected, $test-name;
        }
        else
        {
            ok @exp-strs.elems == 1 && @exp-strs[0] eq '-1', $test-name;
        }
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 1  2  3  4  5               |2| 1  2  3   | 4  5
        Example 2| 1  2  3  4  5  6            |3| 1  2| 3  4| 5  6
        Example 3| 1  2  3                     |2| 1  2| 3
        Example 4| 1  2  3  4  5  6  7  8  9 10|5| 1  2| 3  4| 5  6| 7  8| 9 10
        Example 5| 1  2  3                     |4|-1
        Example 6|72 57 89 55 36 84 10 95 99 35|7|72 57|89 55|36 84|10|95|99|35
        END
}

################################################################################
