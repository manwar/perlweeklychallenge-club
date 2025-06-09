#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
324-1: 2D Array             Submitted by: Mohammad Sajid Anwar
You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns using the given array.


Example 1
Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])

Example 2
Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])

Example 3
Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

=end comment

my @Test =
    { ary => (1, 2, 3, 4), rows => 2, cols => 2, exp => ([1, 2], [3, 4]) },
    { ary => (1, 2, 3),    rows => 1, cols => 3, exp => ([1, 2, 3],) },
    { ary => (1, 2, 3, 4), rows => 4, cols => 1, exp => ([1], [2], [3], [4]) },
;
my @Die =
    { ary => (1, 2, 3),    rows => 2, cols => 3, },
    { ary => (1, 2, 3),    rows => -1, cols => -3, },
    { ary => (),           rows => 2, cols => 3, },
;
plan +@Test + @Die;

sub task( List:D $ary, Int:D $rows, Int:D $cols -->Array) {
    die 'Shape not possible' if $ary.elems ≠ $rows × $cols or $rows < 0;
    return (@$ary.rotor( $cols)».Array).Array;
}

for @Test -> %h {
    is task( %h<ary>, %h<rows>, %h<cols>), %h<exp>,
        "%h<exp>.raku() <- [%h<ary>]∘∘ %h<rows> X %h<cols>";
}
for @Die -> %h {
    dies-ok { task( %h<ary>, %h<rows>, %h<cols>)}, 'Illegal inputs'
}
done-testing;

my @int = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
my $rows = 3;
my $cols = 4;
say qq{\nInput: @int = @int.raku(), \$rows = $rows, \$cols = $cols\n}
    ~ "Output: {task(@int, $rows, $cols).raku} ";


