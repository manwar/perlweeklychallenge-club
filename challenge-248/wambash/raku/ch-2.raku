#!/usr/bin/env raku


sub submatrix-sum (+a) {
    a
    andthen .map: *.rotor( 2 => -1 ).map: *.sum
    andthen .rotor: 2 => -1
    andthen .map: -> (@f, @s) { @f Z+ @s }
}

multi MAIN (Bool :test($)!) {
    use Test;
    cmp-ok submatrix-sum((1...12).rotor(4)), &[~~], ((14,18,22),(30,34,38));
    cmp-ok submatrix-sum((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)), &[~~], ((2,1,0),(1,2,1),(0,1,2));
    done-testing;
}

multi MAIN (+a) {
    say submatrix-sum +a
}
