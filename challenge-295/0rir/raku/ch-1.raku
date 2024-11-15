#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
295-1: Word Break           Submitted by: Mohammad Sajid Anwar
You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be segmented into a space separated sequence of one or more words from the given list.

Example 1
Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true
Example 2
Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true
Example 3
Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

=end comment

my @Test =
        # string                match                       expect
     '',                    <a a>,                      False,
     'weeklyweekly',        ('weekly',),                True, # SPEC is ?able
     'weekly',              <weekly weekly>,            True,
     'weekly',              <challenge weekly>,         True,
     'weeklychallenge',     <challenge weekly>,         True,
     "perlrakuperl",        <raku perl>,                True,
     "sonsanddaughters",    <sons and daughters>,       True,
     "sonsanddaughters",    <sons sand daughters>,      False,
     "sonssanddaughters",    <sons sand daughters>,     True,
     "eeeee",               <a b c d e>,                True,
     "eweweweek",           <e we ewe wee week>,        True,
     "eweweweek",           <we ewe wee week>,          True,
;
my @Dead =
        'a',                 (),                # emplty list
        'a',                 ('',),             # not list of words
        'a',                 ('','a',),         # not list of words
;
plan @Test ÷ 3 + @Dead ÷ 2;

# Can Str be broken into subset of $w words
only task( Str:D $s, List:D $l -->Bool) {
    use MONKEY;
    my $r =    EVAL 'regex {   ^ [' ~ $l.join('+| ') ~ '+]+ $ }' ;
    so $s ~~ $r;
}

for @Dead -> $in, $w {
    dies-ok { task($in, $w) }, "Dies-ok <- $in ∘/ $w.raku() /";
}
for @Test -> $in, $w, $exp {
    is task($in, $w), $exp, "$exp <- $in ∘ $w";
}
done-testing;

my $str = 'thisisastringofcarrottiersthis';
my @w   = <str tiers this in isa gof carrot>; 
say "\nInput: \$str = $str, @word = @w[]\nOutput: &task($str, @w)";
