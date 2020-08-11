#!/usr/bin/env perl6

use v6;

sub MAIN() {
    my @L = (-25, -10, -7, -3, 2, 4, 8, 10);
    my $S = @L.elems - 1;
    my $T = 0;

    for 0 .. $S -> $i {
        for 0 .. $S -> $j {
            next if $i == $j;
            for 0 .. $S -> $k {
                next if ($k == $i) || ($k == $j);
                say "[" ~ @L[$i] ~ ", " ~ @L[$j] ~ ", " ~ @L[$k] ~ "]"
                    if @L[$i] + @L[$j] + @L[$k] == $T;
            }
        }
    }
}
