#! /usr/bin/raku

use Test;

plan 2;

is(lastelement([3, 8, 5, 2, 9, 2]), 1, 'example 1');
is(lastelement([3, 2, 5]), 0, 'example 2');

sub lastelement(@a) {
    my @b = @a;
    loop {
        @b = @b.sort({$^a <=> $^b});
        my $f = @b.pop;
        my $s = @b.pop;
        if ($f > $s) {
            @b.push($f - $s);
        }
        if (@b.elems == 0) {
            return 0;
        }
        if (@b.elems == 1) {
            return @b[0];
        }
    }
}
