#! /usr/bin/raku

use Test;

plan 3;

is(numberplacement([1, 0, 0, 0, 1], 1), True, 'example 1');
is(numberplacement([1, 0, 0, 0, 1], 2), False, 'example 2');
is(numberplacement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3), True, 'example 3');

sub numberplacement(@a0, $ct) {
    my @a = (1, );
    @a.append(@a0);
    @a.push(1);
    my $s = 0;
    my $tt = 0;
    for (1..@a.end) -> $i {
        if (@a[$i - 1] == 1 && @a[$i] == 0) {
            $s = $i;
        } elsif (@a[$i - 1] == 0 && @a[$i] == 1) {
            $tt += floor(($i - $s)/2);
        }
    }
    return $ct <= $tt;
}
