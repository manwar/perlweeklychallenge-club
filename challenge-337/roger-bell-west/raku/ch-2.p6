#! /usr/bin/raku

use Test;

plan 5;

is(oddmatrix(2, 3, [[0, 1], [1, 1]]), 6, 'example 1');
is(oddmatrix(2, 2, [[1, 1], [0, 0]]), 0, 'example 2');
is(oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]), 0, 'example 3');
is(oddmatrix(1, 5, [[0, 2], [0, 4]]), 2, 'example 4');
is(oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]), 8, 'example 5');

sub oddmatrix($rows, $cols, @points) {
    my %rm = SetHash.new;
    my %cm = SetHash.new;
    for @points -> @p {
        if (%rm{@p[0]}:exists) {
            %rm{@p[0]}:delete;
        } else {
            %rm{@p[0]}++;
        }
        if (%cm{@p[1]}:exists) {
            %cm{@p[1]}:delete;
        } else {
            %cm{@p[1]}++;
        }
  }
  %rm.elems * ($cols - %cm.elems) + %cm.elems * ($rows - %rm.elems);
}
