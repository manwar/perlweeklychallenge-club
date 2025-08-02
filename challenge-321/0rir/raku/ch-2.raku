#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
321-Task 2: Backspace Compare   Submitted by: Mohammad Sajid Anwar
You are given two strings containing zero or more #.

Write a script to return true if the two given strings are same by treating # as backspace.


Example 1
Input: $str1 = "ab#c"
       $str2 = "ad#c"
Output: true

For first string,  we remove "b" as it is followed by "#".
For second string, we remove "d" as it is followed by "#".
In the end both strings became the same.

Example 2
Input: $str1 = "ab##"
       $str2 = "a#b#"
Output: true

Example 3
Input: $str1 = "a#b"
       $str2 = "c"
Output: false
=end comment

my @Test =
    "ab*c",     "ad*c",     True,
    "ab**",     "a*b*",     True,
    "***ab**",  "**a*b*",   True,
    "ab**",     "***a*b*",  True,

    "a*b",      "c",        False,
    "*a*b",     "c",        False,
    "*a*b",     "***c",     False,
;

my @Test-BS =
    "***c",         "c",
    "ab*c",         "ac",
    "ab**",         "",
    "a*b*",         "",
    "***ab**",      "",
    "***ab****",    "",
    "*a*b*",        "",
    "ab**",         "",
    "ab****",       "",
    "a*b",          "b",
    "c",            "c",
    "*a*b",         "b",
    '*',            '',
;
plan @Test ÷ 3 + @Test-BS ÷ 2;

my $BS-CHAR = '*';  # Using '*' to avoid Test::proclaim's munging.

#  task -- return the 'cmp' of two Strs after processing "backspace"
# characters.  Leading "backspace"s are deleteable.
sub task( $a is copy, $b is copy, :$bs = $BS-CHAR -->Bool) {
    my @bs;
    for $a, $b -> $word {
        @bs.push: apply-bs( $word);
    }
    return @bs[0] eq @bs[1];
}

# apply-bs
# Process "backspace" characters in an Array repping a string.
sub  apply-bs( $w, :$bs = $BS-CHAR -->Str) {
    my @w = $w.comb;
    my $k = -1;
    my @ret;

    while $k < @w.end {
        ++$k;
        when @w[$k] ne $bs {
            @ret.push: @w[$k];
        }
        when @w[$k] eq $bs and @ret.elems > 0 {
            @ret.pop;
        }
        # nought to do: @w[$k] eq $bs and @ret ~~ Empty
    }
    @ret.join;
}
for @Test-BS ->  $in, $exp {
    is apply-bs( $in), $exp, "$exp <- " ~ $in.raku();
}

for @Test -> $a, $b, $exp {
    is task($a, $b ), $exp, "$exp  <- @$a[] ∘∘ @$b[]";
}
done-testing;

$BS-CHAR = '#';
my $str1 = "ab#xy##c#####a#b#abcdefg######ce###acb#";
my $str2 = "ad#c";

say "\nInput: \$str1 = $str1\n       \$str2 = $str2\nOutput: ",
    task( $str1, $str2);
