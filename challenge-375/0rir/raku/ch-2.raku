#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
May be edited for space.
375-2: Find K-Beauty       Submitted by: Mohammad Sajid Anwar
You are given a number and a digit (k).

Write a script to find the K-Beauty of the given number. The K-Beauty of an integer number is defined as the number of substrings of given number when it is read as a string has length of ‘k’ and is a divisor of given number.
=end comment

my @Test =
    # in    k   exp
    240,    2,  2,
    1020,   2,  3,
    444,    2,  0,
    17,     2,  1,
    123,    1,  2,
    1020,   1,  2,          # Division of zed is discounted.
    100020, 3,  2,
    -444,   2,  1,          # Negative numbers are not in spec ??? NYI
;
plan +@Test ÷ 3;

sub task(Int:D() $in, Int() $k where 0 < * < 10 -->Int:D) {
    my $num = $in.Str;
    my $ret = 0;
    my Range $r = 0 .. $k-1;
    while $r.max < $num.chars {
        my $ss = $num.substr: $r;
        $r += 1;
        next if $ss == 0;                                       # ??? 
        ++$ret if $in %% $ss ;
    }
    $ret;
}

for @Test -> $in, $k, $exp {
    is task( $in, $k), $exp, "$exp <- $in.raku() ∘∘ $k";
}
done-testing;

my $num = 123;
my $k = 1;

say qq{\nInput: \$num = $num, \$k = $k\nOutput: &task($num, $k)};
