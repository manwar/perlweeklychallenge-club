#! /usr/bin/perl6

use Test;

plan 3;

is(is_weird(12),
   False,
   'example 1');

is(is_weird(13),
   False,
   'example 2');

is(is_weird(70),
   True,
   'example 3');

sub divisors($n) {
    my @ff=[1];
    if ($n==1) {
        return @ff;
    }
    my $s=floor(sqrt($n));
    if ($s * $s == $n) {
        @ff.push($s);
        $s--;
    }
    for 2..$s -> $pf {
        if ($n % $pf == 0) {
            @ff.push($pf);
            @ff.push($n div $pf);
        }
    }
    return @ff;
}

sub is_weird($n) {
    my @dd=divisors($n);
    if (@dd.sum() <= $n) {
        return False;
    }
    for 1..(1 +< @dd.elems)-1 -> $mask {
        my $ss=0;
        for @dd.kv -> $i,$d {
            if ($mask +& (1 +< $i) > 0) {
                $ss += $d;
                if ($ss > $n) {
                    last;
                }
            }
            if ($ss == $n) {
                return False;
            }
        }
    }
    return True;
}
