#! /usr/bin/raku

use Test;

plan 2;

is(onesandzeroes(['10', '0001', '111001', '1', '0'], 5, 3), 4, 'example 1');
is(onesandzeroes(['10', '1', '0'], 1, 1), 2, 'example 2');

sub onesandzeroes(@a, $zeroes, $ones) {
    my @ax;
    for @a -> $ns {
        my $o = 0;
        my $n = 0;
        for $ns.comb -> $c {
            if ($c eq '0') {
                $o++;
            } elsif ($c eq '1') {
                $n++;
            }
        }
        @ax.push([$o, $n]);
    }
    my $mx = 0;
    for 1..^(1 +< @ax.elems) -> $mask {
        my $o = 0;
        my $n = 0;
        my $ct = 0;
        for @ax.kv -> $i, @x {
            if ($mask +& (1 +< $i)) {
                $o += @x[0];
                $n += @x[1];
                $ct++;
                if ($o > $zeroes || $n > $ones) {
                    last;
                }
            }
        }
        if ($o <= $zeroes && $n <= $ones) {
            $mx = max($mx, $ct);
        }
    }
    $mx;
}
