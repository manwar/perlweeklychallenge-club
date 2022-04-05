#! /usr/bin/perl6

use Test;

plan 3;

is(moebius(5),-1,'example 1');
is(moebius(10),1,'example 2');
is(moebius(20),0,'example 3');

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
    for genprimes(floor(sqrt($n))) -> $p {
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

sub moebius($n) {
    my $z=0;
    for primefactor($n).values -> $v {
        if ($v > 1) {
            return 0;
        }
        $z++;
    }
    if ($z % 2 == 0) {
        return 1;
    }
    return -1;
}
