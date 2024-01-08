#! /usr/bin/raku

use Test;

plan 2;

is-deeply(shortestdistance('loveleetcode', 'e'), [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0], 'example 1');
is-deeply(shortestdistance('aaab', 'b'), [3, 2, 1, 0], 'example 2');

sub shortestdistance($a, $c) {
    my @q;
    my $i = 0;
    while (True) {
        with ($a.index($c, $i)) {
            @q.push(($_, 0));
            $i = $_ + 1;
        } else {
            last;
        }
    }
    my $invalid = $a.chars + 1;
    my @out = $invalid xx $a.chars();
    while (@q.elems > 0) {
        my ($i, $v) = @q.shift;
        if (@out[$i] == $invalid) {
            @out[$i] = $v;
            if ($i > 0) {
                @q.push(($i - 1, $v + 1));
            }
            if ($i < $a.chars - 1) {
                @q.push(($i + 1, $v + 1));
            }
        }
    }
    return @out;
}
