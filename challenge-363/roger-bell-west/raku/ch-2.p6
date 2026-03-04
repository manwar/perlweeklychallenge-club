#! /usr/bin/raku

use Test;

plan 6;

is(subnetsheriff('192.168.1.45', '192.168.1.0/24'), True, 'example 1');
is(subnetsheriff('10.0.0.256', '10.0.0.0/24'), False, 'example 2');
is(subnetsheriff('172.16.8.9', '172.16.8.9/32'), True, 'example 3');
is(subnetsheriff('172.16.4.5', '172.16.0.0/14'), True, 'example 4');
is(subnetsheriff('192.0.2.0', '192.0.2.0/25'), True, 'example 5');
is(subnetsheriff('172.16.4.5', '172.17.0.0/14'), True, 'example 6');

sub parseaddr($a) {
    my $out = 0;
    for $a.split('.') -> $os {
        if ($os >= 0 && $os < 256) {
            $out *= 256;
            $out += $os;
        } else {
            return -1;
        }
    }
    $out;
}

sub subnetsheriff($addrs, $nets) {
    my $addr = parseaddr($addrs);
    if ($addr >= 0) {
        my @netsc = $nets.split('/');
        my $netmask = parseaddr(@netsc[0]);
        if ($netmask >= 0) {
            my $netlen = 0 + @netsc[1];
            if ($netlen >= 0 && $netlen <= 32) {
                my $bits = (1 +< (32 - $netlen)) - 1;
                my $netlo = $netmask +& !$bits;
                my $nethi = $netmask +| $bits;
                if ($addr >= $netlo && $addr <= $nethi) {
                    return True;
                }
            }
        }
    }
    False;
}
