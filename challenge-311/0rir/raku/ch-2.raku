#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use Test;

=begin comment
311-Task 2: Group Digit Sum         Submitted by: Mohammad Sajid Anwar
You are given a string, $str, made up of digits, and an integer, $int,
which is less than the length of the given string.

Write a script to divide the given string into consecutive groups of
size $int (plus one for leftovers if any). Then sum the digits of each
group, and concatenate all group sums to create a new string. If the
length of the new string is less than or equal to the given integer then
return the new string, otherwise continue the process.

Example 1
Input: $str = "111122333", $int = 3
Output: "359"

Step 1: "111", "122", "333" => "359"
Example 2
Input: $str = "1222312", $int = 2
Output: "76"

Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"
Example 3
Input: $str = "100012121001", $int = 4
Output: "162"

Step 1: "1000", "1212", "1001" => "162"
=end comment

=begin interp
The int must be > 1.
=end interp

my @Test =
    "111122333",    3,  "359",
    "1222312",      2,  "76",
    "100012121001", 4,  "162",
    "9999999",      6,  "549",
    "9999999",      5,  "4518",
    "9999999",      4,  "3627",
    "9999999",      3,  "36",
    "9999999",      2,  "99",
;
my @Dead =
    "9999999",      1,
    Str,            2,
    '999999',       Int,
;
plan @Test ÷ 3 + @Dead ÷ 2;

multi task( Str   $ret,         Int $size where * < 2          ) {
    die "Undefined or bad args"                                  }

multi task( Str:D $ret is copy, Int $size where * <  $ret.chars) {
    while $ret.chars > $size {
        $ret=$ret.comb( $size => 0, :partial).map( *.comb.sum).join;    # XXX
    }
    $ret
}

for @Test -> $str, $int, $exp {
    is task( $str, $int), $exp, "{$exp // $exp.^name()}\t<- $int\t∘∘ $str";
}
for @Dead -> $str, $int {
    dies-ok { task( $str, $int) }, "Dies\t<- $int.raku()\t∘∘ $str.raku()";
}

done-testing;

my $str = "7" x 50;
my $int = 7;
say "\n #\$str is \"7\" x 50";
say "Input: \$str = \"$str\", \$int = $int\nOutput: \"{task $str, $int}\"";
