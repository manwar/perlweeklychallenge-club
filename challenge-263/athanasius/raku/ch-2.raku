use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 263
=========================

TASK #2
-------
*Merge Items*

Submitted by: Mohammad Sajid Anwar

You are given two 2-D array of positive integers, $items1 and $items2 where
element is pair of (item_id, item_quantity).

Write a script to return the merged items.

Example 1

  Input: $items1 = [ [1,1], [2,1], [3,2] ]
         $items2 = [ [2,2], [1,3] ]
  Output: [ [1,4], [2,3], [3,2] ]

  Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
  Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
  Item id (3) appears 1 time: [3,2]

Example 2

  Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
         $items2 = [ [3,1], [1,3] ]
  Output: [ [1,8], [2,3], [3,3] ]

Example 3

  Input: $items1 = [ [1,1], [2,2], [3,3] ]
         $items2 = [ [2,3], [2,4] ]
  Output: [ [1,1], [2,9], [3,3] ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The "positive" integers include zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The 2-D lists $items1 and $items2 are entered as named-argument strings on
   the command-line.
 - Each string comprises items (pairs of positive integers) separated by white-
   space.
 - Within each item pair, item_id and item_quantity are separated by a single
   comma (no whitespace).

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 263, Task #2: Merge Items (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$items1,    #= 1st space-separated list of comma-separated UInt pairs
    Str:D :$items2     #= 2nd space-separated list of comma-separated UInt pairs
)
#===============================================================================
{
    my Pair @items1 = parse-items-list( $items1 );
    my Pair @items2 = parse-items-list( $items2 );

    "Input: \$items1 = %s\n".printf: display-items( @items1 );
    "       \$items2 = %s\n".printf: display-items( @items2 );

    my Pair @merged = merge-items( @items1, @items2 );

    "Output: merged = %s\n"\.printf: display-items( @merged );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub merge-items
(
    List:D[Pair:D] $items1,
    List:D[Pair:D] $items2
--> List:D[Pair:D]
)
#-------------------------------------------------------------------------------
{
    my UInt %quantity{UInt};

    for |$items1, |$items2 -> Pair $p
    {
        %quantity{ $p.key } += $p.value;
    }

    my Pair @merged-items;

    for %quantity.keys.sort -> UInt $id
    {
        @merged-items.push: $id => %quantity{ $id };
    }

    return @merged-items;
}

#-------------------------------------------------------------------------------
sub parse-items-list( Str:D $items-str --> List:D[Pair:D] )
#-------------------------------------------------------------------------------
{
    my Pair @items;
    my Str  @item-strs = $items-str.split: / \s+ /, :skip-empty;

    for @item-strs -> Str $item-str
    {
        $item-str ~~ / ^ (<-[,]>+) \, (<-[,]>+) $ /
                       or error( qq[Malformed item pair "$item-str"] );

        my Str ($id, $quantity) = ~$0, ~$1;

        for $id, $quantity
        {
            +$_ ~~ Int or error( qq["$_" is not a valid integer] );
            +$_ >= 0   or error( qq["$_" is not a positive integer] );
        }

        @items.push: $id.Int => $quantity.Int;
    }

    return @items;
}

#-------------------------------------------------------------------------------
sub display-items( List:D[Pair:D] $items --> Str:D )
#-------------------------------------------------------------------------------
{
    return '[ %s ]'.sprintf:
        $items.map( { '[%s]'.sprintf: .kv.join: ',' } ).join: ', ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $items1-str, $items2-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $items1-str, $items2-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pair @items1   = parse-items-list( $items1-str );
        my Pair @items2   = parse-items-list( $items2-str );
        my Pair @expected = parse-items-list( $expected-str );
        my Pair @merged   = merge-items( @items1, @items2 );

        is-deeply @merged, @expected, $test-name;
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
        Example 1|1,1 2,1 3,2    |2,2 1,3|1,4 2,3 3,2
        Example 2|1,2 2,3 1,3 3,2|3,1 1,3|1,8 2,3 3,3
        Example 3|1,1 2,2 3,3    |2,3 2,4|1,1 2,9 3,3
        END
}

################################################################################
