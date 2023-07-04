#! /usr/bin/raku

use Test;

plan 3;

is(countprimes(10), 4, 'example 1');
is(countprimes(1), 0, 'example 2');
is(countprimes(20), 8, 'example 3');

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

sub countprimes($l) {
    return genprimes($l).elems;
}
