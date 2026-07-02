#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
380-1: Reverse String       Submitted by: Mohammad Sajid Anwar
You are given a string.
Write a script to reverse the given string without using standard reverse function.
=end comment

my @Test =
    # in                            exp
    "",                             "",
    "reverse the given string",     "gnirts nevig eht esrever",
    "Perl is Awesome",              "emosewA si lreP",
    "v1.0.0-Beta!",                 "!ateB-0.0.1v",
    "racecar",                      "racecar",
;
plan +@Test ÷ 2;

sub task( Str:D $a --> Str:D) {
    my Str $ret = '';
    for $a.chars^...0 -> \i {
        $ret ~= $a.substr( i,1);
    }
    $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;

my $str = "Raku is something";

say qq{\nInput: \$str = "$str"\nOutput: "&task( $str)"};


