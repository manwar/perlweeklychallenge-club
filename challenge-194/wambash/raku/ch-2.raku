#!/usr/bin/env raku

sub frequency-equalizer ($s) {
    $s
    andthen .comb
    andthen .Bag
    andthen all .values.minmax == 2, .maxpairs == 1
    andthen .so
}

multi MAIN (Bool :test($)!) {
    use Test;
    is frequency-equalizer('abbc'), True;
    is frequency-equalizer('xyzyyxz'), True;
    is frequency-equalizer('xzxz'), False;
    is frequency-equalizer('aabbcccddd'), False;
    is frequency-equalizer('aabbccccdd'), False;
    done-testing;
}

multi MAIN ($s) {
    say +frequency-equalizer $s
}
