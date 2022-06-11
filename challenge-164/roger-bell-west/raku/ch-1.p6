#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(primepal(1000),[2, 3, 5, 7, 11, 101, 131, 151, 181, 191,
                          313, 353, 373, 383, 727, 757, 787, 797, 919,
                          929],'example 1');

sub isnumpal($c0) {
    my $c = $c0;
    my $j = 0;
    while ($c > 0) {
        $j = 10*$j + $c % 10;
        $c div= 10;
    }
    return $c0 == $j;
}

sub primepal($pmax) {
    return [genprimes($pmax).grep({isnumpal($_)})];
}

sub genprimes($mx) {
    my @primes;
    {
        my $primesh=(2,3).SetHash;
        loop (my $i=6;$i <= $mx+1; $i += 6) {
            for ($i-1,$i+1) -> $j {
                if ($j <= $mx) {
                    $primesh{$j}=True;
                }
            }
        }
        my $p=2;
        my @q=[2,3,5,7];
        my $mr=floor(sqrt($mx));
        while ($p <= $mr) {
            if ($primesh{$p}:exists) {
                my $i=$p*$p;
                while ($i <= $mx) {
                    $primesh{$i}:delete;
                    $i += $p;
                }
            }
            if (@q.elems < 2) {
                @q.push(@q[*-1]+4);
                @q.push(@q[*-1]+2);
            }
            $p=@q.shift;
        }
        @primes=$primesh.keys.sort;
    }
    return @primes;
}
