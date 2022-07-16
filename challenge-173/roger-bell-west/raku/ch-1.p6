#! /usr/bin/perl6

use Test;

plan 5;

is(esthetic10(5456),
   True,
   'example 1');

is(esthetic10(120),
   False,
   'example 2');

is(esthetic10(12),
   True,
   'example 3');

is(esthetic10(5654),
   True,
   'example 4');

is(esthetic10(890),
   False,
   'example 5');


sub esthetic10($n) {
    return esthetic($n,10);
}

sub esthetic($n0,$base) {
    my $n = $n0;
    my $pdigit;
    my $ch = False;
    while ($n > 0) {
        my $digit = $n % $base;
        if ($ch && abs($digit - $pdigit) != 1) {
            return False;
        }
        $ch = True;
        $pdigit = $digit;
        $n = floor($n / $base);
    }
    return True;
}
