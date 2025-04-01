#! /usr/bin/raku

use Test;

plan 3;

is(sortcolumn(['swpc', 'tyad', 'azbe']), 2, 'example 1');
is(sortcolumn(['cba', 'daf', 'ghi']), 1, 'example 2');
is(sortcolumn(['a', 'b', 'c']), 0, 'example 3');

sub arraycomp(@a, @b) {
    if (@a.elems != @b.elems) {
        return False;
    }
    for @a.kv -> $i, $c {
        if (@b[$i] ne $c) {
            return False;
        }
    }
    True;
}

sub sortcolumn(@a) {
    my @vv;
    for @a.kv -> $i, $s {
        for $s.comb.kv -> $j, $c {
            if ($i == 0) {
                @vv.push([]);
            }
            @vv[$j].push($c);
        }
    }
    my $tot = 0;
    for @vv -> @x {
        my @y = @x.sort;
        unless (arraycomp(@x, @y)) {
            $tot++;
        }
    }
    $tot;
}
