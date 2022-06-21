#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(primorial(5),
          [1, 2, 6, 30, 210],
          'example 1');

is-deeply(primorial(10),
          [1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870],
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

sub nthprimelimit($n) {
    my $m=15;
    if ($n >= 6) {
        $m=floor(1+$n*log($n*log($n)));
    }
    return $m;
}

sub primorial($ct) {
    my @o=(1);
    for genprimes(nthprimelimit($ct-1)) -> $p {
        push @o,@o[*-1] * $p;
        if (@o.elems >= $ct) {
            last;
        }
    }
    return @o;
}
