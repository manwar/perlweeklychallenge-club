#! /usr/bin/raku

use Test;

plan 4;

is(collectpoints([2, 4, 3, 3, 3, 4, 5, 4, 2]), 23, 'example 1');
is(collectpoints([1, 2, 2, 2, 2, 1]), 20, 'example 2');
is(collectpoints([1]), 1, 'example 3');
is(collectpoints([2, 2, 2, 1, 1, 2, 2, 2]), 40, 'example 4');

sub collectpoints(@a) {
    my @m;
    my $s = 0;
    while ($s < @a.elems) {
        my $k = @a[$s];
        my $e = $s;
        while ($e < @a.elems && @a[$e] == $k) {
            $e++;
        }
        @m.push([$k, $e - $s]);
        $s = $e;
    }
    my $rv = 0;
    my @stack = [[@m, 0], ];
    while (@stack.elems > 0) {
        my @s = @stack.pop.List;
        if (@s[0].elems == 0) {
            $rv = max($rv, @s[1]);
        } else {
            for (0..@s[0].end) -> $i {
                my @ss = [@s[0].map({[$_.[0], $_.[1]]}).Array, @s[1]];
                @ss[1] += @ss[0][$i][1] * @ss[0][$i][1];
                splice @ss[0], $i, 1;
                my $j = $i;
                while (True) {
                    if ($j > 0 &&
                        $j < @ss[0].elems &&
                        @ss[0][$j][0] == @ss[0][$j-1][0]) {
                        @ss[0][$j][1] += @ss[0][$j-1][1];
                        splice @ss[0], $j - 1, 1;
                        $j--;
                    } else {
                        last;
                    }
                }
                @stack.push(@ss);
            }
        }
    }
    return $rv;
}
