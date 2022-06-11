#! /usr/bin/perl6

use Test;

plan 2;

is(pisano(3),8,'example 1');
is(pisano(6),24,'example 2');

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

sub gcd($m0,$n0) {
    my ($m,$n)=($m0,$n0);
    while ($n != 0) {
        ($m,$n)=($n,$m % $n);
    }
    return $m;
}

sub lcm($m,$n) {
    return $m/gcd($m,$n)*$n;
}

sub primefactor($n) {
    my %f;
    my $m=$n;
    for (2,3,5,7) -> $p {
        while ($m % $p == 0) {
            %f{$p}++;
            $m=floor($m/$p);
        }
    }
    if ($m > 1) {
        for genprimes($m) -> $p {
            while ($m % $p == 0) {
                %f{$p}++;
                $m=floor($m/$p);
            }
            if ($m == 1) {
                last;
            }
        }
    }
    return %f;
} 

sub pisano($n) {
    my $a=1;
    for primefactor($n).kv -> $k,$v {
        my $nn=$k ** $v;
        my $t=1;
        my @x=(1,1);
        while (@x[0] != 0 || @x[1] != 1) {
            $t++;
            @x=(@x[1],(@x[0]+@x[1]) % $nn);
        }
        $a=lcm($a,$t);
    }
    return $a;
}
