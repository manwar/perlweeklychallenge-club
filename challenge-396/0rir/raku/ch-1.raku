#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited for no good reason:
396-Task 1: Finishing Order     Submitted by: Mohammad Sajid Anwar
You are given two array of integers, @order and @friends.

The @order (size n) contains every integer from 1 to n exactly once. The
@friends contains ID in sorted in strictly increasing order.

Write a script to return the array containing IDs in finishing order.
=end comment

my @Test =
    { order => (3,1,4,2,5),   friends => (1,2,4),   expect => (1,4,2),   },
    { order => (5,4,3,2,1),   friends => (1,3,5),   expect => (5,3,1),   },
    { order => (2,4,1,3),     friends => (1,2,3,4), expect => (2,4,1,3), },
    { order => (4,1,3,2),     friends => (3),       expect => (3),       },
    { order => (1,3,2,6,5,4), friends => (1,2,3),   expect => (1,3,2),   },
;
plan +@Test;

sub task( List:D() $order, Set:D() $friends --> List:D) {
    my @ret;
    for @$order {
        @ret.push: $_ if $_ ∈ $friends;
    }
    @ret.List;
}

for @Test -> %t  {
    is task( %t<order>, %t<friends>), %t<expect>;
}
done-testing;

my @order   = (3, 1, 4, 2, 5);
my @friends = (1, 2, 4);

say qq{\nInput: @order =  @order.List.raku()},
    qq{\n       @friends =  @friends.List.raku()},
    qq{\nOutput: }, task( @order, @friends).List.raku;
