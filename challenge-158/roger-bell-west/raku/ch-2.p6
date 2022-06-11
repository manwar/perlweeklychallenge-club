#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(cuban1(1000),
          [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919],
          'example 1');

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

sub cuban1($mx) {
    my @o;
    my $ps=Set.new(genprimes($mx));
    for 1..$mx -> $y {
        my $q = 3*$y*($y+1)+1;
        if ($q > $mx) {
            last;
        }
        if ($ps{$q}:exists) {
            @o.push($q);
        }
    }
    return @o;
}
