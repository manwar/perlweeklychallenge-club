#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
002-1
Write a script or one-liner to remove leading zeros from positive numbers.
=end comment

my @Test =
    '00000005.1', '5.1',
    '0005.1', '5.1',
    '005.1', '5.1',
    '05.1', '5.1',
    '5.1', '5.1',
    5.1, '5.1',
    .051, '.051',
    0.0051, '.0051',
    0.1, '.1',
;
plan @Test ÷ 2;

sub func( $n where $n.Rat > 0 -->Str ){ $n.subst( / ^ '0'+ /); }

for @Test -> $in, $exp {
    is func($in), $exp, "$exp <- $in";
}

done-testing;

exit;

