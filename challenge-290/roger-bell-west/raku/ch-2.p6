#! /usr/bin/raku

use Test;

plan 3;

is(luhnalgorithm('17893729974'), True, 'example 1');
is(luhnalgorithm('4137 8947 1175 5904'), True, 'example 2');
is(luhnalgorithm('4137 8974 1175 5904'), False, 'example 3');

sub luhnalgorithm($a) {
    my @digits = $a.comb.grep(/\d/);
    my $payload = @digits.pop;
    @digits = @digits.reverse;
    loop (my $i = 0; $i < @digits.elems; $i += 2) {
        @digits[$i] *= 2;
        if (@digits[$i] > 9) {
            @digits[$i] -= 9;
        }
    }
    10 - (@digits.sum % 10) == $payload;
}
