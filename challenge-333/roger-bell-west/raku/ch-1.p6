#! /usr/bin/raku

use Test;

plan 4;

is(straightline([[2, 1], [2, 3], [2, 5]]), True, 'example 1');
is(straightline([[1, 4], [3, 4], [10, 4]]), True, 'example 2');
is(straightline([[0, 0], [1, 1], [2, 3]]), False, 'example 3');
is(straightline([[1, 1], [1, 1], [1, 1]]), True, 'example 4');

sub straightline(@a) {
    my @b;
    for @a -> @xy {
        my $u = True;
        for @b -> @bxy {
            if (@xy[0] == @bxy[0] && @xy[1] == @bxy[1]) {
                $u = False;
                last;
            }
        }
        if ($u) {
            @b.push(@xy);
        }
    }
    if (@b.elems < 3) {
        return True;
    }
    my $p = @b[0][0];
    my $q = @b[1][0] - @b[0][0];
    my $r = @b[0][1];
    my $s = @b[1][1] - @b[0][1];
    for (2 .. @b.end) -> $tp {
        my @tpair = @b[$tp].flat;
        if ($q == 0 && @tpair[0] != @b[0][0]) {
            return False;
        }
        if ($s == 0 && @tpair[1] != @b[0][1]) {
            return False;
        }
        if ($q != 0 && $s != 0) {
            my $n1 = (@tpair[0] - $p ) / $q;
            my $n2 = (@tpair[1] - $r ) / $s;
            if ($n1 != $n2) {
                return False;
            }
        }
    }
    True;
}
