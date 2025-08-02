#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
314-Task 2: Sort Column
Submitted by: Mohammad Sajid Anwar
You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non sorted columns.

Return the total columns deleted.

Example 1
Input: @list = ("swpc", "tyad", "azbe")
Output: 2

swpc
tyad
azbe

Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.
Example 2
Input: @list = ("cba", "daf", "ghi")
Output: 1
Example 3
Input: @list = ("a", "b", "c")
Output: 0
=end comment

my @Test =
   ("swpc", "tyad", "azbe"), 2,
   ("cba", "daf", "ghi"),    1,
   ("a", "b", "c"),          0,
   ('', '', ''),             0,
;
plan @Test ÷ 2;

sub task( @word -->Int) {
    ( [Z] @word>>.comb ).grep({$_ !~~ .sort }).Int;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()"
}
done-testing;

my $list = ("cba", "daf", "ghi");
say qq{\nInput: \$list = $list\nOutput: &task( $list)};

