#! /usr/bin/raku

use Test;

plan 3;

is(distinctaverage([1, 2, 4, 3, 5, 6]), 1, 'example 1');
is(distinctaverage([0, 2, 4, 8, 3, 5]), 2, 'example 2');
is(distinctaverage([7, 3, 1, 0, 5, 9]), 2, 'example 3');

sub distinctaverage(@a0) {
    my @a = @a0.sort({ $^a <=> $^b });
    my $offset = @a.elems - 1;
    my %res = SetHash.new;
    for 0 ..^ floor(@a.elems / 2) -> $i {
        %res{@a[$i] + @a[$offset - $i]}++;
    }
    %res.elems;
}
