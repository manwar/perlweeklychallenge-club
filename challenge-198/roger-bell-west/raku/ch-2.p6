#! /usr/bin/raku

use Test;

plan 4;

is(primecount(10), 4, 'example 1');
is(primecount(15), 6, 'example 2');
is(primecount(1), 0, 'example 3');
is(primecount(25), 9, 'example 4');

sub genprimes($mx) {
    my @primes;
    {
        my $primesh=(2..(3,$mx).min).SetHash;
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

sub primecount($l) {
    return genprimes($l-1).elems;
}
