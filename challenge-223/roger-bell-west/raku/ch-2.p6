#! /usr/bin/raku

use Test;

plan 2;

is(boxcoins([3, 1, 5, 8]), 167, 'example 1');
is(boxcoins([1, 5]), 10, 'example 2');

sub boxcoins(@ints) {
    my $mx = 0;
    my @stack = [ [ @ints, 0 ], ];
    while (@stack.elems > 0) {
        my @x = @stack.shift.List;
        my @t = @x[0].List;
        my $tot = @x[1];
        if ($tot > $mx) {
            $mx = $tot;
        }
        for (0 .. @t.end) -> $i {
            my $p = @t[$i];
            if ($i > 0) {
                $p *= @t[$i - 1];
            }
            if ($i < @t.end) {
                $p *= @t[$i + 1];
            }
            my $stot = $tot + $p;
            my @tt;
            for (0 .. @t.end) -> $ix {
                if ($i != $ix) {
                    @tt.push(@t[$ix]);
                }
            }
            @stack.push([@tt, $stot]);
        }
    }
    return $mx;
}
