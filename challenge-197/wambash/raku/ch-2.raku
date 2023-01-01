#!/usr/bin/env raku

sub wiggle-sort (+@list) {
    @list
    andthen .sort
    andthen .reverse
    andthen roundrobin .[((.elems div 2) .. *),^(.elems div 2)  ], :slip
}

multi MAIN (Bool :test($)!) {
    use Test;
    is wiggle-sort(1,5,1,1,6,4), (1,6,1,5,1,4);
    is wiggle-sort(1,3,2,2,3,1), (2,3,1,3,1,2);
    todo 'doesn\'t work for some list with odd number of elemnts';
    is wiggle-sort(1,5,5), (5,1,5);
    done-testing;
}

multi MAIN (*@list) {
    put wiggle-sort @list
}
