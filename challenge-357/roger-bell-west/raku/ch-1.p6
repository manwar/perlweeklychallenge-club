#! /usr/bin/raku

use Test;

plan 6;

is(kaprekarconstant(3524), 3, 'example 1');
is(kaprekarconstant(6174), 0, 'example 2');
is(kaprekarconstant(9998), 5, 'example 3');
is(kaprekarconstant(1001), 4, 'example 4');
is(kaprekarconstant(9000), 4, 'example 5');
is(kaprekarconstant(1111), -1, 'example 6');

sub a2n(@a) {
    my $t = 0;
    for @a -> $d {
        $t *= 10;
        $t += $d;
    }
    $t;
}

sub kaprekarconstant($a) {
    my $ct = 0;
    my $b = $a;
    while ($b != 6174) {
        if ($b == 0) {
            return -1;
        }
        my @digits;
        for 0 .. 3 -> $i {
            @digits.push($b % 10);
            $b div= 10;
        }
        @digits = sort @digits;
        my @stigid = @digits.sort({$^b <=> $^a});
        $b = a2n(@stigid) - a2n(@digits);
        $ct++;
    }
    $ct;
}
