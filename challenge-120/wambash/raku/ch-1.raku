#!/usr/bin/env raku

sub  swap-odd-even-bits ($n) {
    my $odd  = $n +& 0b01010101 ;
    my $even = $n +& 0b10101010 ;
    $odd +< 1 +| $even +> 1
}

multi MAIN (Int $n ) {
    say swap-odd-even-bits $n;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is swap-odd-even-bits(101), 154;
    is swap-odd-even-bits(18), 33;
    is swap-odd-even-bits(255), 255;
    is swap-odd-even-bits(1), 2;
    is swap-odd-even-bits(2), 1;
    done-testing;
}
