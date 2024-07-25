#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
279 1: Sort Letters         Submitted by: Mohammad Sajid Anwar

Given two arrays, @letters and @weights, sort the given array
@letters based on the @weights.

Example 1
Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL
Example 2
Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU
Example 3
Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON
=end comment

my @Test =
     ('R', 'E', 'P', 'L'),           (3, 2, 1, 4),       'PERL',
     ('A', 'U', 'R', 'K'),           (2, 4, 1, 3),       'RAKU',
     ('O', 'H', 'Y', 'N', 'P', 'T'), (5, 4, 2, 6, 1, 3), 'PYTHON',
;
my @Die =
    < a a a a>,                     ( 1, 2, 3, 5),
    < x x x x>,                     ( 1, 2,3,),
;
plan @Test ÷ 3 + @Die ÷ 2;

sub task( @value, @order -->Str) {
     my $ret;
     die q{Err: Index count doesn't match data.}
            unless @order.sort ~~ (1 … @value.elems);
     for ^@order -> \i {
        $ret[ @order[i] - 1 ] = @value[i];
     }
     @$ret.join;
}

for @Test -> @value, @order, $exp {
    is task(@value, @order), $exp, "$exp <- @value.raku() ~o~ @order.raku()";
}
for @Die -> @value, @order {
    dies-ok { task(@value, @order)}, "dies <- @value.raku() ~o~ @order.raku()";
}
done-testing;

my @letter = < P E R L >;
my @weight = (3, 2, 1, 4);
say "\nInput : @letters = @letter.raku()\n        @weights = @weight.raku()"
  ~ "\nOutput: ", task( @letter, @weight);

