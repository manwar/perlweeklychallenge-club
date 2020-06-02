#!/usr/bin/env raku

sub MAIN (Str $input) {
        my $tmp = $input;
        for 1 ... ∞ {
                $tmp = $tmp.comb.list.rotate($_ % $tmp.chars).join;
                if ($tmp eq $input) {
                        .say;
                        last;
                }
        }
}
