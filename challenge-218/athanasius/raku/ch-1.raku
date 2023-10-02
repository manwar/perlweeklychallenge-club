use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 218
=========================

TASK #1
-------
*Maximum Product*

Submitted by: Mohammad S Anwar

You are given a list of 3 or more integers.

Write a script to find the 3 integers whose product is the maximum and return
it.

Example 1

  Input: @list = (3, 1, 2)
  Output: 6

  1 x 2 x 3 => 6

Example 2

  Input: @list = (4, 1, 3, 2)
  Output: 24

  2 x 3 x 4 => 24

Example 3

  Input: @list = (-1, 0, 1, 3, 1)
  Output: 3

  1 x 1 x 3 => 3

Example 4

  Input: @list = (-8, 2, -9, 0, -4, 3)
  Output: 216

  -9 × -8 × 3 => 216

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first integer is negative, the input list must be preceded by '--'.
3. If VERBOSE is set to True (the default), the output is followed by an explan-
   ation of the result.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 218, Task #1: Maximum Product (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 3 or more integers

    *@list where { .all ~~ Int:D && .elems >= 3 }
)
#===============================================================================
{
    "Input:  \@list = %s\n".printf: @list.join: ', ';

    my Array[Int] $solution    = Array[Int].new;
    my Int        $max-product = find-max-product( @list, $solution );

    "Output: $max-product".put;

    "\n%s = $max-product\n".printf: $solution.join: ' × ' if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-product
(
    List:D[Int:D]  $list where { .elems >= 3 },
    Array:D[Int:D] $solution is rw
--> Int:D
)
#-------------------------------------------------------------------------------
{
    my Int (@neg, @pos);

    ($_ < 0 ?? @neg !! @pos).push: $_ for @$list;           # Partition the list

    @neg.= sort;                                            # Ascending
    @pos.= sort: { $^b cmp $^a };                           # Descending

    if    $list.elems == 3 || @neg.elems < 2 || @pos.elems == 0
    {
        $solution = Array[Int].new: $list.sort[ *-3 .. *-1 ];
    }
    elsif @pos.elems < 3
    {
        $solution = Array[Int].new: |@neg[ 0 .. 1 ], @pos[ 0 ];
    }
    else
    {
        my Int @neg-soln = Array[Int].new: |@neg[ 0 .. 1 ], @pos[ 0 ];
        my Int @pos-soln = Array[Int].new:  @pos[ 0 .. 2 ];
        my Int $neg-prod = [*] @neg-soln;                   # Product 1
        my Int $pos-prod = [*] @pos-soln;                   # Product 2

        $solution = $neg-prod > $pos-prod ?? @neg-soln !! @pos-soln;
    }

    return [*] @$solution;                                  # Max product
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $list-str, $expected, $soln-str) = $line.split: / \| /;

        for $name, $list-str, $expected, $soln-str             # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Array[Int] $solution = Array[Int].new;

        my Int @list = $list-str.split( / \, \s* /, :skip-empty ).map: { .Int };
        my Int @soln = $soln-str.split( / \, \s* /, :skip-empty ).map: { .Int };
        my Int $got  = find-max-product( @list, $solution );

        is        $got,      $expected.Int, $name;
        is-deeply $solution, @soln,         $name if VERBOSE;
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
        Example 1  | 3,  1,  2          |  6| 1,  2,  3
        Example 2  | 4,  1,  3, 2       | 24| 2,  3,  4
        Example 3  |-1,  0,  1, 3,  1   |  3| 1,  1,  3
        Example 4  |-8,  2, -9, 0, -4, 3|216|-9, -8,  3
        Negative 1 |-2, -3, -1          | -6|-3, -2, -1
        Negative 2 |-2, -3, -1, -10, -10| -6|-3, -2, -1
        Min mixed 1|-1,  5,  2          |-10|-1,  2,  5
        Min mixed 2|-1,  5, -2          | 10|-2, -1,  5
        1 negative | 1,  2,  3,   7,  -4| 42| 2,  3,  7
        2 negatives| 1,  2,  3,  -7,  -4| 84|-7, -4,  3
        3 negatives| 1, -2,  3,  -7,  -4| 84|-7, -4,  3
        Duplicates | 4,  0,  4,   5,  -3| 80| 4,  4,  5
        END
}

################################################################################
