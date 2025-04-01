#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
313-1: Broken Keys          Submitted by: Mohammad Sajid Anwar
You have a broken keyboard which sometimes type a character more than once.
You are given a string and actual typed string.
Write a script to find out if the actual typed string is meant for
the given string.

Example 1
Input: $name = "perl", $typed = "perrrl"
Output: true

Here "r" is pressed 3 times instead of 1 time.
Example 2
Input: $name = "raku", $typed = "rrakuuuu"
Output: true
Example 3
Input: $name = "python", $typed = "perl"
Output: false
Example 4
Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true

=end comment

my @Test =
    # sot           got         exp
    "perl",         "perrrl",           True,
    "raku",         "rrakuuuu",         True,
    "raku",         "rrakuuuur",        False,
    "python",       "perl",             False,
    "coffeescript", "cofffeescccript",  True,
    'aa',           'a',                False,
    'a',            'aa',               True,
    '',             '',                 True,
    '',             'a',                True,
;
plan @Test ÷ 3;

multi task( "", Str:D $got -->Bool) {True}
multi task( Str:D $sot, Str:D $got where *.chars < $sot.chars -->Bool) {False}
multi task( Str:D $sot, Str:D $got -->Bool) {
    my @sot = $sot.comb;
    my @got = $got.comb;

    return False if @sot.squish !~~ @got.squish;

    quietly                  # The warning hiesen-hides.
    while @sot {
        my $val = @sot[0];
        while @sot and $val eq @sot[0] {
            sink @sot.shift;
            my $x = @got.shift;
            return False unless $x.defined and $x eq $val;  # Strange!
        }
        while @got[0] eq $val { sink @got.shift; }
    }
    return True;
}

for @Test -> $sot, $got, $exp  {
    my $splain = ( $exp // $exp.^name).Str ~ " <- $sot ∘∘ $got";
    is task( $sot, $got), $exp, $splain;
}
done-testing;

my $sot = 'coffeescript';
my $got =  'coffescript';

say qq{\nInput: \$name = "$sot", \$typed = "$got"\nOutput: &task($sot, $got)};

