#!/usr/bin/env raku

sub n-queens-threeD($n = 2) {
        my @solutions = [];
        place-queen [^$n X ^$n X ^$n], [], @solutions;
        return indices-to-array @solutions.max(+*), $n;
}


sub place-queen(@indices, @queens, @solutions) {
       @solutions.push([@queens]) if not @indices;
       for @indices -> $pos {
               place-queen(@indices.grep({is-available($pos, $_)}), (|@queens, $pos), @solutions);
       }
}


sub is-available($ref, $pos) {
        my $diff = ($ref »-« $pos)».abs.Set;
        not (+$diff == 1 || (+$diff == 2 && 0 ∈ $diff))
}


sub indices-to-array(@indices, $n) {
    my @array = [[[ 0 xx $n] xx $n] xx $n];
    for @indices -> ($x, $y, $z) {
            @array[$x; $y; $z] = 1;
    }
    return @array;
}


sub MAIN (Int :$n=2) {
        say n-queens-threeD $n;
}
