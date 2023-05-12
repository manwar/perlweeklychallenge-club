#! /usr/bin/raku

use Test;

plan 4;

is(wordstickers(['perl', 'raku', 'python'], 'peon'), 2, 'example 1');
is(wordstickers(['love', 'hate', 'angry'], 'goat'), 3, 'example 2');
is(wordstickers(['come', 'nation', 'delta'], 'accomodation'), 4, 'example 3');
is(wordstickers(['come', 'country', 'delta'], 'accomodation'), 0, 'example 4');


sub wordstickers(@stickers, $word) {
    my $w = BagHash.new($word.lc.comb);
    my $t = $w.clone;
    my @stick;
    for @stickers -> $s {
        my $f = BagHash.new($s.lc.comb);
        map {$t{$_}:delete}, $f.keys;
        @stick.push($f);
    }
    if ($t.elems > 0) {
        return 0;
    }
    my @stack = [[$w, 0],];
    while (@stack.elems > 0) {
        my @st = @stack.shift.flat;
        if (@st[0].elems == 0) {
            return @st[1];
        } else {
            my $n = @st[1] + 1;
            for @stick -> $sti {
                my $sp = @st[0].clone;
                my $v = False;
                for $sti.keys -> $l {
                    if ($sp{$l}:exists) {
                        $v = True;
                        my $p = $sp{$l} - $sti{$l};
                        if ($p > 0) {
                            $sp{$l} = $p
                        } else {
                            $sp{$l}:delete;
                        }
                    }
                }
                if ($v) {
                    @stack.push([$sp, $n]);
                }
            }
        }
    }
}
