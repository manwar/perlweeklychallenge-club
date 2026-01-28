#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

use Sub::Memoized;

=begin comment
May be edited for space.
358-Task 2: Encrypted String
Submitted by: Mohammad Sajid Anwar
You are given a string $str and an integer $int.

Write a script to encrypt the string using the algorithm - for each character $char in $str, replace $char with the $int th character after $char in the alphabet, wrapping if needed and return the encrypted string.
=end comment

my @Test =
    # str   offset   exp
    "abc",      1, "bcd",
    "xyz",      2, "zab",
    "abc",     27, "bcd",
    "hello",    5, "mjqqt",
    "perl",    26, "perl",
    "XyZ",      2, "ZaB",
    "wFPz",    21, 'rAKu',
;
plan +@Test ÷ 3;

subset PosInt of Int where * > 0;

my %position = (('a'...'z') Z=> (0...25)).Map;
my %letter  =  %position.antipairs.Map;
my \letter-ct = 26;

multi task( Str:D $s is copy, PosInt:D \offset -->Str) {
    (   do for 0 ..^$s.chars -> \i {
            $_ = $s.substr(i,1);
            if .lc ne $_ { 
                ( %letter{ (%position{$_.lc} + offset) % letter-ct}).uc;
            } else {
                  %letter{ (%position{$_}    + offset) % letter-ct};
            }
        }
    ).join
}

for @Test -> $in, $offset, $exp {
    is task( $in, $offset), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "wfPz";
my $int = 21;

say qq{\nInput: \$str = "$str", \$int = $int\nOutput: "&task( $str, $int)"}; 
