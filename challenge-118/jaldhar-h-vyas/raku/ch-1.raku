#!/usr/bin/raku

sub MAIN(
    Int $N #= an integer
) {
    my $binary = $N.base(2);
    say ($binary eq $binary.flip) ?? 1 !! 0;
}