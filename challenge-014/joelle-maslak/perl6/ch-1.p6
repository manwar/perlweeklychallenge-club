#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(UInt:D $length = 19) {
    my $seq = lazy gather { for 0..∞ -> $n { take van-eck($n) } }

    say $seq[^$length].join(" ");
}
    
my %cache-by-val = 0 => [0, 1];
my @cache-by-pos = 0, 0;

multi sub van-eck(0 --> UInt:D) { 0 }
multi sub van-eck(1 --> UInt:D) { 0 }
multi sub van-eck(UInt:D $pos --> UInt:D) {

    return @cache-by-pos[$pos] if @cache-by-pos[$pos]:exists;

    # Ensure cache is populated.
    for ^$pos -> $p { van-eck($p) }

    my $n = $pos - 1;

    # We know that we must have been called in order.
    my $prev = van-eck($n);

    my $current;
    if %cache-by-val{$prev} and %cache-by-val{$prev}.elems ≥ 2 {
        my $m = %cache-by-val{$prev}[*-2];
        $current = $n - $m;
    } else {
        $current = 0;
    }
    @cache-by-pos[$pos] = $current;
    ( %cache-by-val{$current} //= Array.new ).push: $pos;

    return $current;
}

