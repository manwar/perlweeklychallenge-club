#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
002-2

Create a script that generates Pascal Triangle. Accept number of rows from the command line. The Pascal Triangle should have at least 3 rows. For more information about Pascal Triangle, check this wikipedia page.
=end comment

my @Test =
    0,
;
plan @Test ÷ 2;

sub func( $a) {
    …
}

for @Test -> $in, $exp {
    is func($in), $exp, "$exp <- $in";
}

done-testing;
my @X = X;

exit;

