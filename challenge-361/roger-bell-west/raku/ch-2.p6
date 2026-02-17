#! /usr/bin/raku

use Test;

plan 6;

is(findcelebrity([[0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0]]), 4, 'example 1');
is(findcelebrity([[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]]), -1, 'example 2');
is(findcelebrity([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0]]), 0, 'example 3');
is(findcelebrity([[0, 1, 0, 1, 0, 1], [1, 0, 1, 1, 0, 0], [0, 0, 0, 1, 1, 0], [0, 0, 0, 0, 0, 0], [0, 1, 0, 1, 0, 0], [1, 0, 1, 1, 0, 0]]), 3, 'example 4');
is(findcelebrity([[0, 1, 1, 0], [1, 0, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]), -1, 'example 5');
is(findcelebrity([[0, 0, 1, 1], [1, 0, 0, 0], [1, 1, 0, 1], [1, 1, 0, 0]]), -1, 'example 6');

sub findcelebrity(@a) {
    my %knowsnobody = SetHash.new;
    my %everybodyknows = SetHash.new;
    for 0 ..@a.end -> $i {
        my @ek = @a.map({$_[$i]});
        splice @ek, $i, 1;
        if (all(@ek) == 1) {
            %everybodyknows{$i}++;
        }
        my @kn = @a[$i].clone;
        splice @kn, $i, 1;
        if (all(@kn) == 0) {
            %knowsnobody{$i}++;
        }
    }
    my %celebs = %everybodyknows (&) %knowsnobody;
    if (%celebs.elems != 1 ) {
        return -1;
    }
    %celebs.keys[0];
}
