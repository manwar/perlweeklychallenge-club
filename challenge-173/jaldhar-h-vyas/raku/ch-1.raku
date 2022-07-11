#!/usr/bin/raku

sub isEsthetic (Int $n) {
    my @digits = $n.comb;
    for 0 ..^ @digits.elems - 1 -> $i {
        if (@digits[$i] - @digits[$i + 1]).abs != 1 {
            return False;
        }
    } 

    return True;
}

sub MAIN(
    Int $n #= an integer
) {
    say "$n is ", isEsthetic($n) ?? q{} !! 'not ', 'an esthetic number';
}