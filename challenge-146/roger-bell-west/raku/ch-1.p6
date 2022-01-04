#! /usr/bin/perl6

use Test;
plan 1;

is(nthprime(10001),104743,'example 1');

sub nthprime($n) {
    my $m=15;
    if ($n >= 6) {
        $m=floor(1+$n*log($n*log($n)));
    }
    my @primes=genprimes($m);
    return @primes[$n-1];
}

sub genprimes($mx) {
    my @primes;
    {
        my $primesh=(2,3).SetHash;
        loop (my $i=6;$i <= $mx; $i += 6) {
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
