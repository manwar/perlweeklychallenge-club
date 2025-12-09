#! /usr/bin/raku

use Test;

plan 5;

is(specialaverage([8000, 5000, 6000, 2000, 3000, 7000]), 5250, 'example 1');
is(specialaverage([100000, 80000, 110000, 90000]), 95000, 'example 2');
is(specialaverage([2500, 2500, 2500, 2500]), 0, 'example 3');
is(specialaverage([2000]), 0, 'example 4');
is(specialaverage([1000, 2000, 3000, 4000, 5000, 6000]), 3500, 'example 5');

sub specialaverage(@a0) {
    my @a = @a0.sort({$^a <=> $^b});
    my $min = @a[0];
    my $max = @a[*-1];
    my @b = @a.grep({$_ != $min && $_ != $max});
    if (@b.elems == 0) {
        return 0;
    }
    @b.sum / @b.elems;
}
