#! /usr/bin/raku

use Test;

plan 5;

is(omega(100061, 0), 3, 'example 1');
is(omega(971088, 0), 3, 'example 2');
is(omega(63640, 1), 6, 'example 3');
is(omega(988841, 1), 2, 'example 4');
is(omega(211529, 0), 2, 'example 5');

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

sub omega($a, $mode) {
    my %pf = primefactor($a);
    if $mode == 0 {
        %pf.elems;
    } else {
        %pf.values.sum;
    }
}
