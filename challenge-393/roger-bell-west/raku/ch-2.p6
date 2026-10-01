#! /usr/bin/raku

use Test;

plan 5;

is(primestep('hello'), 9, 'example 1');
is(primestep('football'), 2, 'example 2');
is(primestep('a'), 0, 'example 3');
is(primestep('challenge'), 2, 'example 4');
is(primestep('perl'), 2, 'example 5');

sub isqrt($n) {
    my $k=$n +> 1;
    my $x=1;
    while ($x) {
        my $k1=($k+floor($n/$k)) +> 1;
        if ($k1 >= $k) {
            $x=0;
        }
        $k=$k1;
    }
    return $k;
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
        my $mr=isqrt($mx);
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


sub primestep($a) {
    my $g = $a.comb.map({$_.ord}).sum;
    my @pm = genprimes($g * 2);
    my $lo = @pm.grep({$_ <= $g})[*-1];
    my $hi = @pm.grep({$_ >= $g})[0];
    min($g - $lo, $hi - $g);
}
