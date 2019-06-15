#!/bin/env perl6

sub common_prefix(Str $a, Str $b) {
    my @a = $a.comb;
    my @b = $b.comb;

    for 0..∞ -> $i {
        last unless @a[$i].defined && @b[$i].defined && @a[$i] eq @b[$i];
        LAST { return @a[0 .. $i - 1].join }
    }
}

my @c = ([[&common_prefix]] 'paths.txt'.IO.lines).comb;
@c.pop while @c[* - 1] ne '/';
@c.pop if @c.elems > 1;

say 'common directory path: ', @c.join;
