#! /usr/bin/raku

use Test;

plan 2;

is(strongpair([1, 2, 3, 4, 5]), 4, 'example 1');
is(strongpair([5, 7, 1, 7]), 1, 'example 2');

sub strongpair(@a0) {
    my @a = @a0.unique.sort({$^a <=> $^b});
    return @a.combinations(2).grep({abs($_[0]-$_[1]) < min($_)}).elems;
}
