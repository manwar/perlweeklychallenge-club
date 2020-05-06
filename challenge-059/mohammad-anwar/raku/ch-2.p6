#!/usr/bin/env perl6

use v6.d;

sub MAIN($A = [2, 3, 4]) {
    say s($A);
}

sub s($A) {

    my $sum = 0;
    for $A.combinations(2) -> $pair {
        $sum += f($pair[0], $pair[1]);
    }

    return $sum;
}

sub f(Int $a, Int $b) {
    my Str $a_binary = $a.base(2);
    my Str $b_binary = $b.base(2);

    my $m = max($a_binary.chars, $b_binary.chars);
    my $f = '%0' ~ $m ~ 'd';
    $a_binary = sprintf($f, $a_binary);
    $b_binary = sprintf($f, $b_binary);
    my @a = $a_binary.comb;
    my @b = $b_binary.comb;

    my $bits = 0;
    for 0..$m-1 -> $i {
        if @a[$i] !== @b[$i] {
            $bits += 1;
        }
    }

    return $bits;
}
