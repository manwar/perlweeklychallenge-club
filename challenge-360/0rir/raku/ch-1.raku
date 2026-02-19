#!/usr/bin/env raku 
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧 use v6.d;
use Test;

=begin comment
May be edited for space.
360-Task 1: Text Justifier          Submitted by: Mohammad Sajid Anwar
You are given a string and a width.
Write a script to return the string that centers the text within that width using asterisks * as padding.

Example 1
Input: $str = "Hi", $width = 5
Output: "*Hi**"
=end comment

constant \FILL-CHAR = '*';

my @Test =
    "Hi",       5,  "*Hi**",
    "Code",    10,  "***Code***",
    "Hello",    9,  "**Hello**",
    "Perl",     4,  "Perl",
    "A",        7,  "***A***",
    "",         5,  "*****",
;
plan +@Test ÷ 3;

multi task( Str:D(Any) $a, Any:D(Int) $width where * == $a.chars) { $a}
multi task( Str:D(Any) $a, Any:D(Int) $width where *  > $a.chars -->Str:D ) {
    my $fill = ($width - $a.chars) ÷ 2;
    (FILL-CHAR x $fill.floor()) ~  $a ~ (FILL-CHAR x $fill.ceiling);
}

for @Test -> $in, $width, $exp {
    is task( $in, $width), $exp, "{$exp // $exp.^name()} <- $in ∘∘ $width";
}
done-testing;

my $str = "Postgres";
my $width = 11;
say qq{\nInput: \$str = "$str", \$width = $width\nOutput: "&task($str, $width)"}
