#! /usr/bin/raku

use Test;

plan 5;

is(thousandseparator(123), '123', 'example 1');
is(thousandseparator(1234), '1,234', 'example 2');
is(thousandseparator(1000000), '1,000,000', 'example 3');
is(thousandseparator(1), '1', 'example 4');
is(thousandseparator(12345), '12,345', 'example 5');

sub thousandseparator($a) {
    my $out = "";
    my @s = $a.comb;
    my $offset = 2 - ((@s.elems + 2) % 3);
    for @s.kv -> $i, $d {
        if ($i > 0 && ($i + $offset) % 3 == 0) {
            $out ~= ',';
        }
        $out ~= $d; 
    }
    $out;
}
