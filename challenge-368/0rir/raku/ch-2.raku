#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
368-Task 2: Big and Little Omega        Submitted by: Roger Bell_West
You are given a positive integer $number and a mode flag $mode. If the mode flag is zero, calculate little omega (the count of all distinct prime factors of that number). If it is one, calculate big omega (the count of all prime factors including duplicates).
=end comment

constant @prime = 2,3, {repeat { $_+=2} until $_.is-prime; $_} … ∞;

my @Test =                  # in     exp-mode0   exp-mode1
                            100061,       3,          3,
                            971088,       3,          6,
                             63640,       4,          6,
                            988841,       2,          2,
                            211529,       2,          2,

                                 1,       0,          0,
                                 2,       1,          1,
                                12,       2,          3,
    (sum ( flat @prime[0..30] xx 30)),    4,          8,
    ([*] ( flat @prime[0..30] xx 30)),   31,        930,
          ([*] ( flat @prime[0..11])),   12,         12,
                       @prime[99999]⁹,    1,          9,
;
plan 2 × +@Test ÷ 3;

subset Mode of Int where * == one( 0, 1);

only task( Int:D() $num is copy where * > 0,  Mode $mode -->Int:D) {
    my BagHash $ret;
    for @prime -> \p {
        last if p > $num;
        while $num %% p {
            $ret{p}++;
            $num div= p;
        }
    }
    return sum $ret.values if $mode == 1;
    return    +$ret.keys   if $mode == 0;
}

for @Test -> $in, $exp0, $exp1 {
    is task( $in, 0), $exp0, "{$exp0 // $exp0.^name()} <- $in ∘∘ 0";
    is task( $in, 1), $exp1, "{$exp1 // $exp1.^name()} <- $in ∘∘ 1";
}
done-testing;

my $number = 4 × (([*] ( flat @prime[0..11])) - 1);
my $mode = 0;

say qq{\nInput: \$number = $number\n       \$mode   = $mode\nOutput: },
        task( $number, $mode);
