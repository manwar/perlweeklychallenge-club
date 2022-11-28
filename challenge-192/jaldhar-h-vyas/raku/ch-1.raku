#!/usr/bin/raku

sub MAIN(Int $n) {
    my $flip = $n.base(2);
    say (:2($flip) +^ :2(1 x $flip.chars));
}