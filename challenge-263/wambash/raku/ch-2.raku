#!/usr/bin/env raku

sub merge-items (*@items) {
    @items
    andthen .map: *.pairup
    andthen .Bag
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply merge-items([[1,1],[2,1],[3,2]],[[2,2],[1,3]]),(1=>4 ,2=>3,3=>2).Bag;
    is-deeply merge-items([ [1,2], [2,3], [1,3], [3,2] ],[ [3,1], [1,3] ]),(1=>8 ,2=>3,3=>3).Bag;
    is-deeply merge-items([ [1,1], [2,2], [3,3]],[ [2,3], [2,4] ]),(1=>1 ,2=>9,3=>3).Bag;
    done-testing;
}

multi MAIN (*@items) {
    .put for merge-items @items».split(',')
}
