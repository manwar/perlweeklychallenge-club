#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
263-2: Merge Items              Submitted by: Mohammad Sajid Anwar

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

my @Test =
    # itemsA        itemsB          combined
    [],             [],             [],
    [ [1,1], [2,1], [3,2] ],
                [ [2,2], [1,3] ],
                                [ [1,4], [2,3], [3,2] ],

    [ [1,2], [2,3], [1,3], [3,2] ],
                [ [3,1], [1,3] ],
                                [ [1,8], [2,3], [3,3] ],

    [ [1,1], [2,2], [3,3] ],
                [ [2,3], [2,4] ],
                                [ [1,1], [2,9], [3,3] ],
;

plan @Test ÷ 3;

sub inventory-merge( $a, $b) {
    my %p{Int};
    for @$a.append( @$b) -> @e {  %p{ @e[0]} += @e[1]  } # writing over input here!!!
    return (%p<>:kv).rotor(2)».Array .sort ;
}

for @Test ->  $a, $b, $exp  {
    is inventory-merge( $a, $b), $exp,
        $exp.gist
        ~ "\n    <- " ~ $a.gist ~ "  ∪  " ~ $b.gist;
}
done-testing;

my @ii = [ [1,1], [1,2], [1,90], [3,1000], [5,4]];
my @jj = [ [1,10], [10,2], [1,980], [6,1000], [5,5]];

say
"\nInput: \$items1 = @ii.gist()\n       \$items2 = @jj.gist()
Output: &inventory-merge(@ii,@jj).gist()";
