#! /usr/bin/raku

use Test;

plan 4;

is(beautifularrangement(2), 2, 'example 1');
is(beautifularrangement(1), 1, 'example 2');
is(beautifularrangement(10), 700, 'example 3');
is(beautifularrangement(20), 1939684, 'example 4');

sub beautifularrangement($a) {
    my @precalc = [False xx ($a + 1)] xx ($a + 1);
    for 1 .. $a -> $i {
        loop (my $j = $i; $j <= $a; $j += $i) {
            @precalc[$i][$j] = True;
            @precalc[$j][$i] = True;
        }
    }
    my $ct = 0;
    my @stack;
    @stack.push([1 .. $a]);
    while @stack.elems > 0 {
        my @trail = (@stack.pop).flat;
        if (@trail.elems == 1) {
            $ct++;
        } else {
            my $p = $a - @trail.elems + 2;
            for @trail -> $i {
                if @precalc[$i][$p] {
                    my @tt = @trail.grep({$_ != $i});
                    @stack.push(@tt);
                }
            }
        }
    }
    $ct;
}
