#! /usr/bin/raku

use Test;

plan 5;

is(decryptstring('10#11#12'), 'jkab', 'example 1');
is(decryptstring('1326#'), 'acz', 'example 2');
is(decryptstring('25#24#123'), 'yxabc', 'example 3');
is(decryptstring('20#5'), 'te', 'example 4');
is(decryptstring('1910#26#'), 'aijz', 'example 5');

sub decryptstring($a) {
    my $out = "";
    my @c = $a.comb;
    my $s = 0;
    while ($s < @c.elems) {
        my $m = @c[$s];
        if ($s + 2 < @c.elems && @c[$s + 2] eq '#') {
            $m = $m * 10 + @c[$s + 1];
            $s += 2;
        }
        $s++;
        $out ~= chr(96 + $m);
    }
    $out;
}
