#! /usr/bin/raku

use Test;

plan 3;

is(shortesttime(['00:00', '23:55', '20:00']), 5, 'example 1');
is(shortesttime(['01:01', '00:50', '00:57']), 4, 'example 2');
is(shortesttime(['10:10', '09:30', '09:00', '09:55']), 15, 'example 3');

sub shortesttime(@n) {
    my $dl = 1440;
    my @nl = @n.map({$_.substr(0, 2) * 60 + $_.substr(3, 2)});
    my @o;
    for @nl.combinations(2) -> @p {
        my $d = abs(@p[0] - @p[1]);
        @o.push($d);
        @o.push($dl - $d);
    }
    return min(@o);
}
