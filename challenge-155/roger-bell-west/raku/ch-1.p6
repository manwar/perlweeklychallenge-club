#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(fortunate(8),
          [3, 5, 7, 13, 17, 19, 23, 37],
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

sub isprime($candidate) {
    if (!is-prime($candidate)) {
        return False;
    } elsif ($candidate==2) {
        return True;
    } elsif ($candidate==3) {
        return True;
    } elsif ($candidate % 2 == 0) {
        return False;
    } elsif ($candidate % 3 == 0) {
        return False;
    }
    my $anchor=0;
    my $limit=floor(sqrt($candidate));
    while (True) {
        $anchor+=6;
        for ($anchor-1,$anchor+1) -> $t {
            if ($t > $limit) {
                return True;
            }
            if ($candidate % $t == 0) {
                return False;
            }
        }
    }
}

sub nthprimelimit($n) {
    my $m=15;
    if ($n >= 6) {
        $m=floor(1+$n*log($n*log($n)));
    }
    return $m;
}

sub fortunate($ct) {
    my $n=$ct*2;
    my @primes=genprimes(nthprimelimit($n));
    my $o=SetHash.new;
    my @ll;
    my $ph=1;
    for @primes -> $p {
        $ph *= $p;
        if ($o.total >= $ct) {
            if ($p >= max($o.keys)) {
                last;
            }
        }
        my $l=$p+1;
        while (!isprime($l+$ph)) {
            $l++;
        }
        $o{$l}=1;
        if ($o.total > $ct) {
            @ll=$o.keys.sort;
            splice @ll,$ct;
            $o=SetHash.new(@ll);
        }
    }
    return @ll;
}
