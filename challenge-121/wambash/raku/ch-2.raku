#!/usr/bin/env raku

sub the-traveling-salesman (@n) {
    permutations(@n.end)
    andthen .race
    andthen .map: { @n.end, |$_, @n.end }\
    andthen .map: { .rotor(2=>- 1) => $_ }\
    andthen .map: { .key.map( -> ($x,$y){@n[$x;$y]}).sum => .value }\
    andthen .min
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @n := [
        [0, 5, 2, 7],
        [5, 0, 5, 3],
        [3, 1, 0, 6],
        [4, 5, 4, 0],
    ];
    is-deeply the-traveling-salesman(@n), 10 => (3,0,2,1,3);
    done-testing;
}

multi MAIN ($n) {
    my @n=(1 ..^ 100).roll($n) xx $n;
    say @n.fmt: '%2d',"\n";
    say the-traveling-salesman(@n);
}
