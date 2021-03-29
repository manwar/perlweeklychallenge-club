#!/usr/bin/raku

sub MAIN(
    Int $N, #= root
    Int $k  #= number
) {
    say ($k ** (1.0 / $N)).round(0.01);
}