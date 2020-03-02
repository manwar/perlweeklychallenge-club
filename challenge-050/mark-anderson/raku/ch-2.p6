#!/usr/bin/env perl6

my @L = [2, 6, 1, 3];

for ^@L {
    my $n = @L.shift;

    if $n <= @L.elems {
        if @L.grep(* > $n).elems == $n {
            say $n;
        }
    }

    @L.push($n);
}
