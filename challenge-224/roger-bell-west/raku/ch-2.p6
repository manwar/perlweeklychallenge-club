#! /usr/bin/raku

use Test;

plan 3;

is(additivenumber('112358'), True, 'example 1');
is(additivenumber('12345'), False, 'example 2');
is(additivenumber('199100199'), True, 'example 3');

sub exdigits(@digits, $start, $end) {
    my Int $x = 0;
    for $start .. $end -> $i {
        $x *= 10;
        $x += @digits[$i];
    }
    return $x;
}

sub additivenumber($digitstring) {
    my @digits = $digitstring.comb;
    my @stack;
    for 0 .. @digits.elems - 3 -> $i {
        for $i + 1 .. @digits.elems - 2 -> $j {
            @stack.push((0, $i, $j));
        }
    }
    while (@stack.elems > 0) {
        my ($start_a, $end_a, $end_b) = @stack.pop;
        my $start_b = $end_a + 1;
        my $val_ab = exdigits(@digits, $start_a, $end_a) +
                             exdigits(@digits, $start_b, $end_b);
        my $start_c = $end_b + 1;
        for $start_c .. @digits.end -> $end_c {
            if ($val_ab == exdigits(@digits, $start_c, $end_c)) {
                if ($end_c == @digits.end) {
                    return True;
                } else {
                    @stack.push(($start_b, $end_b, $end_c));
                    last;
                }
            }
        }
    }
    return False;
}
