#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(primepartition(18, 2),
          [13, 5],
          'example 1');

is-deeply(primepartition(19, 3),
          [11, 5, 3],
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

sub primepartition($n, $divs) {
    my @pl = genprimes($n);
    my @p = [[],];
    while (@p.elems > 0) {
        my @pa = @p.pop.flat;
        if @pa.elems == $divs {
            if @pa.sum == $n {
                return @pa;
            }
        } else {
            my $px = @pa.SetHash;
            for @pl -> $pq {
                unless ($px{$pq}:exists) {
                    my @pb = @pa.clone;
                    @pb.push($pq);
                    @p.push(@pb);
                }
            }
        }
    }
    return [$n];
}
