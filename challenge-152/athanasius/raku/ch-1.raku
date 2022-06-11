use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 152
=========================

TASK #1
-------
*Triangle Sum Path*

Submitted by: Mohammad S Anwar

You are given a triangle array.

Write a script to find the minimum sum path from top to bottom.

Example 1:

 Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]

                 1
                5 3
               2 3 4
              7 1 0 2
             6 4 5 2 8

 Output: 8

     Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8

Example 2:

 Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]

                 5
                2 3
               4 1 5
              0 1 2 3
             7 2 4 1 9

 Output: 9

     Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. Following the Examples, I have assumed that array elements are integers.
2. The array elements are entered on the command line as a linear sequence
   beginning with the top-most element and continuing down and to the right
   until the final (bottom- and right-most) element. For example, the triangu-
   lar array:   1
               2 3
              4 5 6     is entered as:  raku ch-1.raku 1 2 3 4 5 6
3. If the constant $VERBOSE is set to True (the default), the individual elem-
   ents comprising the minimum sum path are shown in addition to the minimum
   sum.

Algorithm
---------
From the Examples, it appears that a "path" is simply a selection of elements
drawn from the triangular array, with exactly one element drawn from each array
level. Hence, the solution is found by taking the smallest element from each
level, and summing these elements.

The following test is used to determine whether the number of elements entered
on the command line is a triangular number:

    "... an integer _x_ is triangular if and only if 8_x_ + 1 is a square." [1]

Reference
---------
[1] https://en.wikipedia.org/wiki/Triangular_number#Triangular_roots_and_tests_
    for_triangular_numbers

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 152, Task #1: Triangle Sum Path (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| A triangular array of integers, in linear order

    *@items where { is-triangular( .elems ) && .all ~~ Int:D }
)
#==============================================================================
{
    my Array[Int] @triangle = build-triangle( @items );

    "Input:  \$triangle = %s\n".printf: sprint-triangle( @triangle );

    my Int @min-sum-path;
           @min-sum-path.push: @triangle[ $_ ].min for 0 .. @triangle.end;

    my Int $min-sum = [+] @min-sum-path;

    "Output: $min-sum".put;

    if $VERBOSE
    {
        "\n    Minimum Sum Path: %s = %d\n".printf:
            @min-sum-path.join( ' + ' ), $min-sum;
    }
}

#------------------------------------------------------------------------------
sub build-triangle( Array:D[Int:D] $items --> Array:D[Array:D[Int:D]] )
#------------------------------------------------------------------------------
{
    my Array[Int] @triangle = Array[Array[Int]].new;
    my UInt       $row-idx  = 0;
    my UInt       $index    = 0;

    while $index <= $items.end
    {
        my Int @row = Array[Int].new;

        for 1 .. $row-idx + 1
        {
            @row.push: $items[ $index++ ];
        }

        @triangle.push: @row;

        ++$row-idx;
    }

    return @triangle;
}

#------------------------------------------------------------------------------
sub sprint-triangle( Array:D[Array:D[Int:D]] $triangle --> Str:D )
#------------------------------------------------------------------------------
{
    my Str @rows;

    for @$triangle -> Array[Int] $row
    {
        @rows.push: '[' ~ @$row.join( ',' ) ~ ']';
    }

    return '[ ' ~ @rows.join( ', ' ) ~ ' ]';
}

#------------------------------------------------------------------------------
sub is-triangular( UInt:D $num --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $x = 8 * $num + 1;

    my UInt $root = $x.sqrt.floor;

    return $root * $root == $x;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
