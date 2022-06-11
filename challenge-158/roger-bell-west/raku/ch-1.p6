#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(additiveprimes(100),
          [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89],
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

sub digitsum($x0) {
    my $s=0;
    my $x=$x0;
    while ($x > 0) {
        $s += $x % 10;
        $x div= 10;
    }
    return $s;
}

sub additiveprimes($mx) {
    my @o;
    my @p=genprimes($mx);
    my $ps=Set.new(@p);
    for @p -> $q {
        if ($ps{digitsum($q)}:exists) {
            @o.push($q);
        }
    }
    return @o;
}
