#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
002-2
Write a script that can convert integers to and from a base35 representation, using the characters 0-9 and A-Y. Dave Jacoby came up with nice description about base35, in case you needed some background.
=end comment

plan 2001;

sub func( Int $a) {     $a.base(35) }

my $n = -10_000_000;
while $n < 10_000_000 {
    $n += 9999;
    is func( $n).parse-base(35), "$n", "N $n -> $n.base(35)";
}

done-testing;
