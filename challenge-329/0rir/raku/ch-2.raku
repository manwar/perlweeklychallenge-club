#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
329-2: Nice String
Submitted by: Mohammad Sajid Anwar
You are given a string made up of lower and upper case English letters only.

Write a script to return the longest substring of the give string which is nice. A string is nice if, for every letter of the alphabet that the string contains, it appears both in uppercase and lowercase.

Example 1
Input: $str = "YaaAho"
Output: "aaA"

Example 2
Input: $str = "cC"
Output: "cC"

Example 3
Input: $str = "A"
Output: ""
=end comment

my @Test =
    # in        exp
    "YaaAho",   "aaA",
    "cC",       "cC",
    "A",        "",
    "",         "",
;
plan 2 +@Test ÷ 2;

# First and rest of a string as Anys in an Array
multi head-tail( Str:D $s is copy --> Array) {
    my Str $head = $s.substr(0,1);
    $s.substr-rw(0, 1) = "";
    return [$head,  $s];
}

# Assume there is an other-case and return it.
sub oc( Str:D $char --> Str:D) {
    $char eq $char.uc ?? $char.lc !! $char.uc
}


# Is it an empty Str or an empty Str of Letters?
#multi task( '') { die 'empty string' }

multi  task( Str $a -->Str:D) {
    my Str $ret = '';
    my Str $s = $a;
   
    while $s.chars > 0 {
        my Str $h;
        ($h, $s) = $s.&head-tail;
        $ret ~= $h if $ret.contains($h, :i) or $s.contains($h.&oc); 
    }
    $ret;
}

is oc( 'a'), 'A', 'other case';
is oc( 'A'), 'a', 'other case';

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "slifdhLasLKFGA";
say qq{\nInput: \$str = "$str"\nOutput: "}, task( $str), '"';
