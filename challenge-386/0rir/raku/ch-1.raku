#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 1: Reverse Base        Submitted by: Mohammad Sajid Anwar

You are given a string representing a number, and an integer specifying the base of that representation.
Write a function to convert this string to an integer. (For bases greater than 10, use characters A-Z, a-z, + and / in that order.)
=end comment

my @Test =
    # number           base          exp
    "101010",            2,           42,
    "EEADEE",           16,     15642094,
    "755",               8,          493,
    "1BRJB",            36,      2228519,
    "7MyqL",            64,    123456789,
    "-7MyqL",           64,   -123456789,
    "+7MyqL",           64,    123456789,
;
my @Dead =
    '7Myql-', 64,
    '7M-yql', 64,
    '7Myql',  36,
    '1043',    4,
    '',       64,
    '-',      10,
    '+',      10,
    '-A',     10,
    '+A',     10,
    '0',       1,
    '1',      65,
;

plan .5 × @Dead + @Test ÷ 3;

constant $minus = '-';
constant $plus  = '+';
constant @wit = flat( '0'…'9', 'A'…'Z', 'a'…'z', '+', '/' )».Str;
my $its = Map.new: @wit »=>» [^@wit];

sub task(   Str:D(Any) $n is copy where *.chars > 0,
            Int:D(Any) \base where 1 < * < 65 --> Int) {

        my Bool $neg = $n.starts-with($minus);

        if $neg or $n.starts-with( $plus) {
            $n.=substr: 1;
            die 'Errdom: empty or only sign' if $n eq '';
        }

        unless $n.comb ⊆ @wit[^base] {
            die "Errdom: found character outside of base";
        }
        $n.=flip;
        my $ret;
        for $n.chars^…0 -> \place {
            my $k = $n.substr: place, 1;
            my $v = $its{$k};
            $ret += $v × base**place;
    }
    $ret = $neg ?? -$ret !! $ret;
}

for @Test -> $val, $base, $exp {
    is task( $val, $base), $exp,  "$exp <- $val ∘∘ $base";
}
for @Dead -> $val, $base {
     dies-ok { task $val, $base}, "dead ok $val ∘∘ $base";
}
done-testing;

my $num = "1BRJB";
my $base = 33;

say qq{\nInput: \$num = "$num", \$base = $base"\nOutput: }, task $num, $base;
