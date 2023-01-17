#! /usr/bin/raku

use Test;

plan 2;

is-deeply(arithmeticslices([1, 2, 3, 4]), [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], 'example 1');
is-deeply(arithmeticslices([2]), [], 'example 2');

sub arithmeticslices(@l) {
    my @o;
    if (@l.elems >= 3) {
        for (0..@l.elems - 3) -> $a {
            my $valid = False;
            for ($a + 2..@l.elems - 1) -> $b {
                my @v = @l[$a..$b];
                unless ($valid) {
                    for (0..@v.elems - 3) -> $i {
                        if (@v[$i + 1] - @v[$i] == @v[$i + 2] - @v[$i + 1]) {
                            $valid = True;
                            last;
                        }
                    }
                }
                if ($valid) {
                    @o.push(@v);
                }
            }
        }
    }
    return @o;
}
