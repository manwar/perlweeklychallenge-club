#! /usr/bin/perl6

use Test;

plan 2;

is(homeprime(10),
   773,
   'example 1');

is(homeprime(16),
   31636373,
   'example 2');

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

sub primefactor($n) {
    my %f;
    my $m=$n;
    for genprimes(1+floor(sqrt($n))) -> $p {
        while ($m % $p == 0) {
            %f{$p}++;
            $m=floor($m/$p);
        }
        if ($m == 1) {
            last;
        }
    }
    if ($m > 1) {
        %f{$m}++;
    }
    return %f;
} 

sub homeprime($n0) {
    my $n = $n0;
    while (True) {
        my $t = primefactor($n);
        if ($t.elems == 1 && $t.values.max() == 1) {
            last;
        }
        my $ns = '';
        for ($t.keys.sort({ $^a <=> $^b })) -> $d {
            for (1..$t{$d}) {
                $ns ~= $d;
            }
        }
        $n = 0 + $ns;
    }
    return $n;
}
