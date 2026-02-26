#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
361-1: Zeckendorf Representation        Submitted by: Mohammad Sajid Anwar
You are given a positive integer (<= 100).
Write a script to return Zeckendorf Representation of the given integer.
Every positive integer can be uniquely represented as sum of non-consecutive Fibonacci numbers.
=end comment

=begin X
It seems that zero is excluded from the representing lists or array.
The numbers 1,2 and 5 are not possible;  3 is doable only by allowing that
the first 1 is not adjacent.  
=end X


constant @fibonacci = 0,1,1, * + * … ^ * > 100; 
my @fib-R = (@fibonacci[2..^(*-1)]).reverse;

my @Test =
    # in        exp
    4,          [3,1],
    12,         [8,3,1],
    20,         [13,5,2],
    96,         [89,5,2],
    100,        [89,8,3],
;

my @Dead = 1,2,5;

plan 1 +@Dead +@Test ÷ 2;

subset Int1to100 of Int where 0 < * < 101;

multi task( Int1to100 $a where * == 5 ) {
    die "Five cannot be built as two and three are adjacent" }
multi task( Int1to100 $a where * == 2 ) {
    die "Two cannot be built as the ones are adjacent." }
multi task( Int1to100 $a where * == 1 ) {
    die "One cannot be built as the other one is singular." }
multi task( Int1to100 $a is copy -->Array) {
    my @ret;
    for 0..^ @fib-R -> $i {      # process non-adjacent cases
        my $f = @fib-R[$i];
        when $a ≥ $f {
            @ret.push( $f);
            $a -= $f;
        }
    }
    @ret;
}

for @Test -> $in, $exp {
    say "\$in  $in";
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
subtest "Test all VALID numbers" => {
    plan 358;
    for flat 3,4,6..100 -> $in {
        is task( $in).sum , $in, " $in sums";
        for task( $in) -> $q {
            ok $q == @fib-R.any,  "$in addend $q is fibonacci";
        }
    }
}
for  @Dead -> $in {
    dies-ok { task $in }, "$in is invalid input";
}
done-testing;

my $int = 88;
say qq{\nInput: \$int = $int\nQutput: }, task($int).join: ','
