#! /usr/bin/raku

use Test;

plan 2;

is-deeply(squareful([1, 17, 8]), [[1, 8, 17], [17, 8, 1]], 'example 1');
is-deeply(squareful([2, 2, 2]), [[2, 2, 2],], 'example 2');

sub squared($a) {
    return $a * $a;
}

sub decode($a0, $base) {
    my @eq;
    my $a = $a0;
    while ($a > 0) {
        @eq.unshift($a % $base);
        $a div= $base;
    }
    return @eq;
}

sub encode(@sq, $base) {
    my $a = 0;
    for @sq -> $v {
        $a *= $base;
        $a += $v;
    }
    return $a;
}

sub squareful(@lst) {
    my $results = SetHash.new;
    my $squares = SetHash.new;
    my $base = max(@lst) + 1;
    for @lst.permutations -> @la {
        my $squareful = True;
        for @la.rotor(2 => -1) -> @a {
            my $cs = @a[0] + @a[1];
            my $mx = squared($squares.elems);
            while ($cs > $mx) {
                $mx = squared($squares.elems + 1);
                $squares{$mx}++;
            }
            unless ($squares{$cs}:exists) {
                $squareful = False;
                last;
            }
        }
        if ($squareful) {
            $results{encode(@la, $base)}++;
        }
    }
    return $results.keys.sort({$^a <=> $^b}).map({decode($_, $base)}).Array;
}
