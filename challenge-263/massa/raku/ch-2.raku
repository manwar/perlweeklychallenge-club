#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Merge items

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two 2-D array of positive integers, $items1 and $items2 where
element is pair of (item_id, item_quantity).

Write a script to return the merged items.

=head3 Example 1:

    Input: $items1 = ((1, 1), (2, 1), (3, 2))
           $items2 = ((2, 2), (1, 3))
    Output: ((1, 4), (2, 3), (3, 2))

=head3 Example 2:

    Input: $items1 = ( (1,2), (2,3), (1,3), (3,2) )
           $items2 = ( (3,1), (1,3) )
    Output: ( (1,8), (2,3), (3,3) )

=head3 Example 3:

    Input: $items1 = ( (1,1), (2,2), (3,3) )
           $items2 = ( (2,3), (2,4) )
    Output: ( (1,1), (2,9), (3,3) )

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@x, @y) {
  my &a2b = { @^a».pairup.Bag }
  my &b2a = { %^b.list».kv.sort }
  b2a( @x.&a2b ⊎ @y.&a2b )
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input =>  ( ((1, 1), (2, 1), (3, 2)), ((2, 2), (1, 3)) ),
           output => ((1, 4), (2, 3), (3, 2)) },
        %{ input =>  ( ( (1,2), (2,3), (1,3), (3,2) ), ( (3,1), (1,3) ) ),
           output => ( (1,8), (2,3), (3,3) ) },
        %{ input =>  ( ( (1,1), (2,2), (3,3) ), ( (2,3), (2,4) ) ),
           output =>  ( (1,1), (2,9), (3,3) ) },
    ;

    SOLUTION(|.<input>).&is: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


