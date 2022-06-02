#! /usr/bin/perl6

use Test;
plan 2;

is-deeply(cyclicpermute(123),
          [231, 312, 123],
          'example 1');

is-deeply(circular(3,10),
          [113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939,
           199933],
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

sub cyclicpermute($n) {
    my $ss = $n;
    my @o;
    for (1..$ss.chars) {
        $ss = substr($ss,1) ~ substr($ss,0,1);
        @o.push(0+$ss);
    }
    return @o;
}

sub circular($mindigits, $ct) {
    my @o;
    my $base = 1;
    for (2..$mindigits) {
        $base *= 10;
    }
    while (@o.elems < $ct) {
        my @pr = genprimes($base * 10);
        my $prs = @pr.SetHash;
        for (@pr) -> $cp {
            if ($cp >= $base) {
                my $v = True;
                my @cpp = cyclicpermute($cp);
                for (@cpp) -> $cpc {
                    unless ($prs{$cpc}:exists) {
                        $v = False;
                        last;
                    }
                }
                if ($v) {
                    @o.push($cp);
                    if (@o.elems >= $ct) {
                        last;
                    }
                    for (@cpp) -> $cpc {
                        $prs{$cpc}:delete;
                    }
                }
            }
        }
        $base *= 10;
    }
    return @o;
}
