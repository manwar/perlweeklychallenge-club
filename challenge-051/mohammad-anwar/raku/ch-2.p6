#!/usr/bin/env perl6

use v6;

sub MAIN() {

    for 102 .. 987 -> $i {
        my $j = $i.comb.unique.join;
        next if $i != $j;

        my @N = $i.comb;
        my @S = (@N[0], @N[1], @N[2], (@N[0] * @N[1]), (@N[1] * @N[2]), (@N[0] * @N[1] * @N[2]));

        say "[$i] => [" ~ @S.join(", ") ~ "]" if @S.unique.elems == @S.elems;
    }
}
