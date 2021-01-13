#!/usr/bin/env perl6

use v6;

sub MAIN() {

    for 234 .. 987 -> $i {
        my $j = $i.comb.unique.join;
        # Only try if all three digits are unique.
        next if $i != $j;

        my @N = $i.comb;
        my @S = (@N[0], @N[1], @N[2], (@N[0] * @N[1]), (@N[1] * @N[2]), (@N[0] * @N[1] * @N[2]));

        say "[$i] => [" ~ @S.join(", ") ~ "]" if @S.unique.elems == @S.elems;
    }
}
