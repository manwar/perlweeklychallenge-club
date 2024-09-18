#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
287-1: Strong Password      Submitted by: Mohammad Sajid Anwar

You are given a string, $str.
Write a program to return the minimum number of steps required to make the given string very strong password. If it is already strong then return 0.

Criteria:

- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter and at least one digit.
- It shouldn't contain 3 repeating characters in a row.
Following can be considered as one step:

- Insert one character
- Delete one character
- Replace one character with another
Example 1
Input: $str = "a"
Output: 5
Example 2
Input: $str = "aB2"
Output: 3
Example 3
Input: $str = "PaaSW0rd"
Output: 0
Example 4
Input: $str = "Paaasw0rd"
Output: 1
Example 5
Input: $str = "aaaaa"
Output: 2
=end comment

my @Test =
    # in              exp run=2 ll=1 lu=1 nd=1
    "",               6,    0,  1,   1,   1,
    "a",              5,    0,  0,   1,   1,
    "aB2",            3,    0,  0,   0,   0,
    "PaaSW0rd",       0,    0,  0,   0,   0,
    "Paaasw0rd",      1,    1,  0,   0,   0,
    "aaaaa",          2,    1,  0,   1,   1,
    "&&&&&",          3,    1,  1,   1,   1,
    "&&&&&&",         3,    2,  1,   1,   1,
    "aaaaa&&&&&&",    3,    3,  0,   1,   1,
    "aaaaa&&&&&&bbb", 4,    4,  0,   1,   1,
    "aaaaa&&&&&&",    3,    3,  0,   1,   1,
    "abcdefg",        2,    0,  0,   1,   1,
    "abcdef",         2,    0,  0,   1,   1,
    "abcdef",         2,    0,  0,   1,   1,
    "abcdef",         2,    0,  0,   1,   1,
    "abCd5f",         0,    0,  0,   0,   0,
    "abCd5",          1,    0,  0,   0,   0,
;
plan @Test × 1 ÷ 6;  # 5 ÷ 6;

    # It must have at least 6 characters.
constant \min-length = 6;
    # It must contains at least one lowercase letter,
constant \min-Ll = 1;
    # at least one upper case letter
constant \min-Lu = 1;
    #   and at least one digit.
constant \min-Nd = 1;
    # It shouldn't contain 3 repeating characters in a row.
constant \break-seq = 3;

sub ll-need( $str) { max 0, min-Ll - ( $str ~~ m:g/ <:Ll> / ) }
sub lu-need( $str) { max 0, min-Lu - ( $str ~~ m:g/ <:Lu> / ) }
sub nd-need( $str) { max 0, min-Nd - ( $str ~~ m:g/ <:Nd> / ) }

multi adjacent-count( $a where *.chars == 0 ) { 0 }
multi adjacent-count( $a where *.chars > 0 ) {
    my @rep;
    my @char = $a.comb;

    my $i = 1;
    my $count;
    while $i < @char {
        $count = 1;
        while  $i < @char  and  @char[$i] eq @char[$i -1] {
            ++$i; ++$count;
        }
        if $count ≥  break-seq {
            @rep.push: $count div break-seq ;
        } else {
            ++$i;
        }
    }
    sum @rep;
}

# I am pressuming that the specified minimum required length suffices
# to contain all the other requirements.

# Adding chars for length or changing chars for over long sequences, both
# can make char class requirements also.

multi task( '' ) { min-length }
multi task( Str() $_ ) {
    my ($len-or-brk, $missing);
    $len-or-brk = max 0, min-length - .chars;       # addition
    $len-or-brk += sum .&adjacent-count;
    $missing = .&ll-need + .&lu-need + .&nd-need;
    $len-or-brk > $missing ?? $len-or-brk !! $missing;
}

for @Test -> $in, $exp, $adjacents, $ll, $lu, $nd {
#   is adjacent-count($in), $adjacents,
#                          "    breaks $adjacents <- '$in'";
#   is ll-need( $in), $ll, "Ll needed " ~ $ll ~ " <- '$in'";
#   is lu-need( $in), $lu, "Lu needed " ~ $lu ~ " <- '$in'";
#   is nd-need( $in), $nd, "Nd needed " ~ $nd ~ " <- '$in'";
    is task($in), $exp,    "$exp <- '$in'";
}
done-testing;

my $str = '@!-$%,<.';
say "\nInput: $str\nOutput: ", task $str;
