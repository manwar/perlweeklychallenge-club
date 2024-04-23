#! /usr/bin/raku

use Test;

plan 3;

is-deeply(uncommonwords('Mango is sweet', 'Mango is sour'), ['sweet', 'sour'], 'example 1');
is-deeply(uncommonwords('Mango Mango', 'Orange'), ['Orange'], 'example 2');
is-deeply(uncommonwords('Mango is Mango', 'Orange is Orange'), [], 'example 3');

sub getlistset($a) {
    my @la = $a.split(' ');
    my %ca;
    @la.map({%ca{$_}++});
    @la = @la.grep({%ca{$_} == 1});
    return (@la, Set(%ca.keys));
}

sub uncommonwords($a, $b) {
    my ($la, $sa) = getlistset($a);
    my ($lb, $sb) = getlistset($b);
    my @out;
    for ([$la, $sb], [$lb, $sa]) -> (@wl, %t) {
        for @wl -> $w {
            unless (%t{$w}:exists) {
                @out.push($w);
            }
        }
    }
    return @out;
}
