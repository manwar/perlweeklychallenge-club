#!/usr/bin/env raku

use v6.d;

sub merge-items(@items1, @items2 --> Positional) {
    my %dict;
    my @res;
    map({ %dict{ $_[0] } += $_[1] }, @items1);
    map({ %dict{ $_[0] } += $_[1] }, @items2);
    map({ @res.push([$_.Int, %dict{$_}]) }, %dict.keys);
    return @res;
}

#| Run test cases
multi sub MAIN() {
    use Test;
    plan 3;

    is sort(merge-items([ [1,1], [2,1], [3,2] ], [ [2,2], [1,3] ])),
        [ [1,4], [2,3], [3,2] ], 'works for [ [1,4], [2,3], [3,2] ]';
    is sort(merge-items([ [1,2], [2,3], [1,3], [3,2] ], [ [3,1], [1,3] ])),
        [ [1,8], [2,3], [3,3] ], 'works for [ [1,8], [2,3], [3,3] ]';
    is sort(merge-items([ [1,1], [2,2], [3,3] ], [ [2,3], [2,4] ])),
        [ [1,1], [2,9], [3,3] ], 'works for [ [1,1], [2,9], [3,3] ]';
}
