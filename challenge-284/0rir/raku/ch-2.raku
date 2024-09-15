#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
284-2: Relative Sort       Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.

Example 1
Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
Example 2
Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
Example 3
Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
=end comment

my @Test =      # sort-me       by-order    / expect
    (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5),      (2, 1, 4, 3, 5, 6),
                (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9),
    (3, 3, 4, 6, 2, 4, 2, 1, 3),            (1, 3, 2),
                (1, 3, 3, 3, 2, 2, 4, 4, 6),
    (3, 0, 5, 0, 2, 1, 4, 1, 1),            (1, 0, 3, 2),
                (1, 1, 1, 0, 0, 3, 2, 4, 5),
;
plan @Test ÷ 3;

sub task( List $to-sort, List $by-order --> List) {
    my @ret;
    my %h = $to-sort.BagHash;
    for $by-order».Int -> \n {
        if %h{n} :exists { @ret.append: n  xx ( %h{ n} :delete); }
    }
    for %h.keys.sort     { @ret.append: $_ xx   %h{$_}   ; }
    @ret;
}

for @Test -> $to-sort, $by-order, $exp {
    is task($to-sort, $by-order), $exp, "$exp <- $to-sort ∘∘ $by-order";
}

done-testing;
my @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
my @list2 = (2, 1, 4, 3, 5, 6);

say "\n Input: @list1 = @list1[]\n        @list2 = @list2[]\n"
    ~ " Output:         { task @list1, @list2 }";


