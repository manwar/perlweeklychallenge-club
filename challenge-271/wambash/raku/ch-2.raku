#!/usr/bin/env raku

my &sort-by-one-bits = &sort.assuming: { .polymod( 2 xx * ).sum => $_  };

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-by-one-bits(0..8),(0,1,2,4,8,3,5,6,7);
    is sort-by-one-bits((1024,512,256,128,64)), (64,128,256,512,1024);
    done-testing;
}

multi MAIN (+ints) {
    put sort-by-one-bits ints
}
