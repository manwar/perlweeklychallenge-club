#! /usr/bin/raku

use Test;

plan 2;

is(nestedarray([5, 4, 0, 3, 1, 6, 2]), 4, 'example 1');
is(nestedarray([0, 1, 2]), 1, 'example 2');

sub nestedarray(@a) {
    my $arr = 0;
    for 0 ..^ @a.elems -> $i {
        my %trail = SetHash.new;
        my $j = $i;
        while (True) {
            $j = @a[$j];
            if (%trail{$j}:exists) {
                last;
            }
            %trail{$j}++;
        }
        $arr = [$arr, %trail.elems].max;
    }
    $arr;
}
