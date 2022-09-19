#! /usr/bin/perl6

use Test;

plan 1;

is(permutable(), 142857, 'example 1');

sub permutable {
    my $n = 0;
    while (True) {
        $n++;
        my $base = $n.comb.sort.join;
        my $q = True;
        for (2..6) -> $k {
            if (($n*$k).comb.sort.join ne $base) {
                $q = False;
                last;
            }
        }
        if ($q) {
            return $n;
        }
    }
}
