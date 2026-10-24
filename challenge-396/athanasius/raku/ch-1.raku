use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 396
=========================

TASK #1
-------
*Finishing Order*

Submitted by: Mohammad Sajid Anwar

You are given two array of integers, @order and @friends.

The @order (size n) contains every integer from 1 to n exactly once. The
@friends contains ID in sorted in strictly increasing order.

Write a script to return the array containing IDs in finishing order.

Example 1

  Input: @order = (3, 1, 4, 2, 5)
         @friends = (1, 2, 4)
  Output: (1, 4, 2)

  ID 1 finished 2nd.
  ID 4 finished 3rd.
  ID 2 finished 4th.

Example 2

  Input: @order = (5, 4, 3, 2, 1)
         @friends = (1, 3, 5)
  Output: (5, 3, 1)

  ID 5 finished 1st.
  ID 3 finished 3rd.
  ID 1 finished 5th.

Example 3

  Input: @order = (2, 4, 1, 3)
         @friends = (1, 2, 3, 4)
  Output: (2, 4, 1, 3)

  ID 2 finished 1st.
  ID 4 finished 2nd.
  ID 1 finished 3rd.
  ID 3 finished 4th.

Example 4

  Input: @order = (4, 1, 3, 2)
         @friends = (3)
  Output: (3)

Example 5

  Input: @order = (1, 3, 2, 6, 5, 4)
         @friends = (1, 2, 3)
  Output: (1, 3, 2)

  ID 1 finished 1st.
  ID 3 finished 2nd.
  ID 2 finished 3rd.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string is a list of
   positive integers separated by whitespace and/or commas.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 396, Task #1: Finishing Order (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $order,           #= A list of n integers, 1 to n
    Str:D $friends          #= A list of integers in the range 1 to n
)
#===============================================================================
{
    my Pos @order   = parse-order\ ( $order );
    my Pos @friends = parse-friends( $friends, @order.elems );

    "Input:  \@order   = (%s)\n".printf: @order\ .join: ', ';
    "        \@friends = (%s)\n".printf: @friends.join: ', ';

    my Pos @finishing = find-finishing-order( @order, @friends );

    "Output: (%s)\n".printf: @finishing.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-finishing-order
(
    List:D[Pos:D] $order,
    List:D[Pos:D] $friends
--> List:D[Pos:D]
)
#-------------------------------------------------------------------------------
{
    my UInt %dict{Pos};

    %dict{ $order[$_] } = $_ for 0 .. $order.end;

    return $friends.sort( { %dict{ $^a } <=> %dict{ $^b } } ).list;
}

#-------------------------------------------------------------------------------
sub parse-order( Str:D $order-str --> List:D[Pos:D] )
#-------------------------------------------------------------------------------
{
    my Pos @order = $order-str.split( / \s+ || \, \s* /, :skip-empty )
                              .map: { .Int };

    for @order -> Pos $n
    {
        $n ~~ Int:D             or error( qq["$n" is not a valid integer] );
        @order.elems >= $n >= 1 or error( "$n is out of range");
    }

    my Pos @in-order = @order.sort: { $^a <=> $^b };

    # @order (size n) contains every integer from 1 to n exactly once

    for 0 .. @in-order.end -> UInt $i
    {
        @in-order[$i] == $i + 1  or error( "\@order is invalid" );
    }

    return @order;
}

#-------------------------------------------------------------------------------
sub parse-friends( Str:D $friends-str, UInt:D $n --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my Pos @friends = $friends-str.split( / \s+ || \, \s* /, :skip-empty )
                                  .map: { .Int };

    for @friends -> Pos $f
    {
        $f ~~ Int:D   or error( qq["$f" is not a valid integer] );
        $n >= $f >= 1 or error( "$f is out of range");
    }

    # @friends contains ID in @sorted in strictly increasing order

    for 1 .. @friends.end -> Pos $i
    {
        @friends[$i] > @friends[$i - 1] or error( "\@friends is invalid" );
    }

    return @friends;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $order-str, $friends-str, $exp-str) =
                $line.split: '|';

        for     $test-name, $order-str, $friends-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos @order     = parse-order( $order-str );
        my Pos @friends   = parse-friends( $friends-str, @order.elems );
        my Pos @finishing = find-finishing-order( @order, @friends );
        my Pos @expected  = $exp-str.split( / \s+ / ).map: { .Int };

        is-deeply @finishing, @expected, $test-name;
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
        Example 1|3 1 4 2 5  |1 2 4  |1 4 2
        Example 2|5 4 3 2 1  |1 3 5  |5 3 1
        Example 3|2 4 1 3    |1 2 3 4|2 4 1 3
        Example 4|4 1 3 2    |3      |3
        Example 5|1 3 2 6 5 4|1 2 3  |1 3 2
        END
}

################################################################################
