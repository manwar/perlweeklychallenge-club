#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
219-1: Sorted Squares          Submitted by: Mohammad S Anwar
Given a list of numbers, square each number in the list and return the
sorted list, increasing order.

Example 1
Input: @list = (-2, -1, 0, 3, 4)
Output: (0, 1, 4, 9, 16)
Example 2
Input: @list = (5, -4, -1, 3, 6)
Output: (1, 9, 16, 25, 36)

=end comment

my @Test =
    (-2, -1, 0, 3, 4),  (0, 1, 4, 9, 16),
    (5, -4, -1, 3, 6),  (1, 9, 16, 25, 36),
;

plan +@Test  ÷ 2;

sub square-sort( @l -->Seq)  { @l.map(*²).sort; }

for @Test -> @in, @exp {
    is square-sort(@in), @exp, "@exp[]\t<- @in[]";
}
done-testing;

my @list = (5, -5, -100, 101, 3, 6);
say "\nInput: @list = @list[]\nOutput: &square-sort( @list)";
exit;

