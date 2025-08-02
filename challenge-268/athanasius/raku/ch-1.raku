use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 268
=========================

TASK #1
-------
*Magic Number*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each elements of one
of the array gives the second array. Elements order is not important.

Example 1

  Input: @x = (3, 7, 5)
         @y = (9, 5, 7)
  Output: 2

  The magic number is 2.
  @x = (3, 7, 5)
     +  2  2  2
  @y = (5, 9, 7)

Example 2

  Input: @x = (1, 2, 1)
         @y = (5, 4, 4)
  Output: 3

  The magic number is 3.
  @x = (1, 2, 1)
     +  3  3  3
  @y = (5, 4, 4)

Example 3

  Input: @x = (2)
         @y = (5)
  Output: 3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input lists @x and @y are entered as two strings on the command-line:
   each string is a list of whitespace-separated integers.

Algorithm
---------
Assume there is a magic number m that satisfies the requirement that when m is
added to each element of @x it produces @y (ignoring element order). Let there
be n elements in each of @x and @y, and let the elements of @x be sorted in monotonically-ascending order as x1 <= x2 <= x3 <= ... <= xn. Likewise, let the
elements of @y be y1 <= y2 <= y3 <= ... <= yn.

Suppose that x1 + m = y2, and that y2 > y1. Then y1's counterpart in @x would be
x0 = y1 - m, and since y1 < y2, we have x0 < x1, which is impossible since x1 is
lowest in sort order. It follows that x1's counterpart in @y can only be y1 (or
another y equal to y1). So we can remove the pair (x1, y1) and apply the same
reasoning to the remaining elements of @x and @y recursively. We conclude that
if m exists, it must be the difference between corresponding elements of the two
ordered arrays. That is, x1 + m = y1, x2 + m = y2, ... xn + m = yn.

This leads to a straightforward algorithm:

    SUB find-magic-number
        Sort @x in increasing numerical order
        Sort @y in increasing numerical order
        m    := y1 - x1
        fail := False
        i    := 1
        WHILE not fail AND i <= n
            diff := yi - xi
            IF diff ≠ m
                fail := True
            ENDIF
            i := i + 1
        ENDWHILE
        IF fail
            m := undefined
        ENDIF
        RETURN m
    ENDSUB

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 268, Task #1: Magic Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $x,             #= A list of integers separated by whitespace
    Str:D $y              #= Another integer list of the same size
)
#===============================================================================
{
    my Array[Int] ($x-array, $y-array) = parse-command-line( $x, $y );

    "Input:  \@x = (%s)\n".printf: $x-array.join: ', ';
    "        \@y = (%s)\n".printf: $y-array.join: ', ';

    my Int $magic = find-magic-number( $x-array, $y-array );

    "Output: %s\n".printf: $magic // 'none';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-magic-number
(
    List:D[Int:D] $x,
    List:D[Int:D] $y where { .elems == $x.elems }
--> Int
)
#-------------------------------------------------------------------------------
{
    my Int @x-sorted = $x.sort;
    my Int @y-sorted = $y.sort;
    my Int $magic    = @y-sorted[ 0 ] - @x-sorted[ 0 ];

    for 1 .. $x.end -> UInt $i
    {
        return unless @y-sorted[ $i ] - @x-sorted[ $i ] == $magic;
    }

    return $magic;
}

#-------------------------------------------------------------------------------
sub parse-command-line( Str:D $x, Str:D $y --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Str @x-strs = $x.split: / \s+ /, :skip-empty;
    my Str @y-strs = $y.split: / \s+ /, :skip-empty;

    @x-strs.elems == @y-strs.elems
        or error( '@x and @y are of different sizes' );

    my Int (@x, @y);

    for @x-strs
    {
        +$_ ~~ Int or error( qq["$_" is not a valid integer] );
        @x.push: +$_;
    }

    for @y-strs
    {
        +$_ ~~ Int or error( qq["$_" is not a valid integer] );
        @y.push: +$_;
    }

    return @x, @y;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $x-str, $y-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $x-str, $y-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @x     = $x-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @y     = $y-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $magic = find-magic-number( @x, @y );

        if $magic.defined
        {
            is $magic, $exp-str.Int, $test-name;
        }
        else
        {
            is 'none', $exp-str,     $test-name;
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
        Example 1 | 3  7  5| 9  5  7| 2
        Example 2 | 1  2  1| 5  4  4| 3
        Example 3 | 2      | 5      | 3
        None      | 1  2   | 3  5   |none
        Zero      | 1  2  3| 2  3  1| 0
        Negative 1|-1 -3 -5|-3  1 -1| 2
        Negative 2|-1 -3 -5|-8 -4 -6|-3
        END
}

################################################################################
