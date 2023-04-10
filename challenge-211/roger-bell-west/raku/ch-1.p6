#! /usr/bin/raku

use Test;

plan 2;

is(toeplitzmatrix([[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]), True, 'example 1');
is(toeplitzmatrix([[1, 2, 3], [3, 2, 1]]), False, 'example 2');

sub toeplitzmatrix(@a) {
    my $ym = @a.end;
    my $xm = @a[0].end;
    my $toeplitz = True;
    for (1 - $xm)..($ym - 1) -> $xb {
        my $init = True;
        my $tv = 0;
        for $xb .. $xb + $xm -> $x {
            if ($x >= 0 && $x <= $xm) {
                my $y = $x - $xb;
                if ($y >= 0 && $y <= $ym) {
                    if ($init) {
                        $init = False;
                        $tv = @a[$y][$x];
                    } elsif (@a[$y][$x] != $tv) {
                        $toeplitz = False;
                        last;
                    }
                }
            }
        }
        unless ($toeplitz) {
            last;
        }
    }
    return $toeplitz;
}
