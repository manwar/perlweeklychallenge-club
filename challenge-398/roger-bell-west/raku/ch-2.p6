#! /usr/bin/raku

use Test;

plan 5;

is(stringdifference(['ab', 'bc', 'cd', 'zy']), 'zy', 'example 1');
is(stringdifference(['cba', 'fed', 'azy']), 'azy', 'example 2');
is(stringdifference(['pop', 'ada', 'beb', 'cfc']), 'pop', 'example 3');
is(stringdifference(['aaaa', 'zzzz', 'mmmm', 'aaba']), 'aaba', 'example 4');
is(stringdifference(['aceg', 'bdfh', 'cegi', 'azbz']), 'azbz', 'example 5');

sub stringdifference(@a) {
    my @da;
    for @a -> $s {
        my @p;
        for $s.comb.rotor(2 => -1) -> @d {
            @p.push(@d[1].ord - @d[0].ord);
        }
        @da.push(@p.join('/'));
    }
    my $dx = 0;
    for 1 .. @a.end -> $b {
        if (@da[0] ne @da[$b]) {
            if ($dx > 0) {
                $dx = 0;
                last;
            } else {
                $dx = $b;
            }
        }
    }
    @a[$dx];
}
