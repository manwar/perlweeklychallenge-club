#! /usr/bin/raku

use Test;

plan 5;

is(shufflepairs(1, 1000, 1), 0, 'example 1');
is(shufflepairs(1500, 2500, 1), 3, 'example 2');
is(shufflepairs(1000000, 1500000, 5), 2, 'example 3');
is(shufflepairs(13427000, 14100000, 2), 11, 'example 4');
is(shufflepairs(1000, 5000, 1), 7, 'example 5');

sub countdigits($a) {
    $a.comb.Bag;
}

sub comparehash($a, $b) {
    unless ($a.elems == $b.elems) {
        return False;
    }
    my $h = SetHash.new;
    for $a.keys -> $k {
        $h.set($k);
    }
    for $b.keys -> $k {
        $h.set($k);
    }
    for $h.keys -> $k {
        unless (($a{$k}:exists) && ($b{$k}:exists) && ($a{$k} == $b{$k})) {
            return False;
        }
    }
    True;
}

sub shufflepairs($low, $high, $pairs) {
    my $total = 0;
    for $low .. $high -> $candidate {
        my %candidatec = countdigits($candidate);
        my $cnt = 0;
        for 2 .. 9 -> $mul {
            my $test = $candidate * $mul;
            my %testc = countdigits($test);
            if (comparehash(%testc, %candidatec)) {
                $cnt++;
                if ($cnt >= $pairs) {
                    last;
                }
            }
        } 
        if ($cnt >= $pairs) {
            $total++;
        }
    }
    $total;
}
