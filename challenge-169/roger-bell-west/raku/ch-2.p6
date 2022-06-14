#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(achilles(20),
          [72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968,
           972, 1125, 1152, 1323, 1352, 1372, 1568, 1800],
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

sub achilles($ct) {
    my @o;
    my $n = 1;
    while (True) {
        $n++;
        my @pv = primefactor($n).values;
        if (@pv.elems > 1 &&
            min(@pv) >= 2 &&
            @pv.reduce(&infix:<gcd>) == 1) {
            push @o,$n;
            if (@o.elems >= $ct) {
                last;
            }
        }
    }
    return @o;
}
