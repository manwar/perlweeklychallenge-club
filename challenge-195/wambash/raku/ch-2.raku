#!/usr/bin/env raku

sub most-frequent-even (+@list) {
    @list
    andthen .grep: * %% 2
    andthen .Bag
    andthen .maxpairs
    andthen .min
    andthen .?key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is most-frequent-even(1,1,2,6,2),2;
    is most-frequent-even(1,3,5,7), Nil;
    is most-frequent-even(6,4,4,6,1), 4;
    done-testing;
}

multi MAIN (*@list) {
    say most-frequent-even( @list ) // -1
}
