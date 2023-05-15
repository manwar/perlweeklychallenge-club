#!/usr/bin/env raku

use v6.d;

sub count-places(Match $zeros --> Int) {
    return ( $zeros.chars - 1 ) ÷ 2;
}

sub number-placement(Int @numbers where 2 > @numbers.all, UInt $count --> UInt) {
    my Str $joined-numbers = @numbers.join;
    $joined-numbers ~~ m:g/ (0+) /;
    return sum(map( &count-places, $/.list)) ≥ $count ?? 1 !! 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is number-placement(Array[Int].new(1,0,0,0,1), 1), 1, 'works for (1,0,0,0,1), 1';
    is number-placement(Array[Int].new(1,0,0,0,1), 2), 0, 'works for (1,0,0,0,1), 2';
    is number-placement(Array[Int].new(1,0,0,0,0,0,0,0,1), 3), 1, 'works for (1,0,0,0,0,0,0,0,1), 3';
    is number-placement(Array[Int].new(1,0,0,0,0,0,0,0,1,0,0,0,1), 4), 1, 'works for (1,0,0,0,0,0,0,0,1,0,0,0,1), 4';
}

#| Take user provided list like x y z
multi sub MAIN(UInt $count, *@numbers where 2 > @numbers.all --> UInt) {
    my Int @int-numbers = @numbers;
    say number-placement(@int-numbers, $count);
}
