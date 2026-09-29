#!/usr/bin/env raku
use Test;

is prime-step("hello"),     9;
is prime-step("football"),  2;
is prime-step("a"),         0;
is prime-step("challenge"), 2;
is prime-step("perl"),      2;

sub prime-step($str)
{
    my $sum = $str.ords.sum;
    my $n = $sum %% 2 ?? $sum - 1 !! $sum;

    my $a = ($n, $n-2 ... 2).first(*.is-prime);
    my $b = ($n, $n+2 ... *).first(*.is-prime);

    (($a,$b) >>->> $sum)>>.abs.min
}
