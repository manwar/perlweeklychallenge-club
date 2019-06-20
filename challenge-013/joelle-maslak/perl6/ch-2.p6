#!/usr/bin/env perl6
use v6;

use experimental :cached;

sub MAIN(UInt:D $length) {
    my @f = lazy (0..∞).map: { F($_) };
    my @m = lazy (0..∞).map: { M($_) };

    say "F: { @f[^$length] }";
    say "M: { @m[^$length] }";
}

multi sub F(0) { 1 }
multi sub M(0) { 0 }

# We cache these results, but can't use the cached trait (because it's a
# multi?), so we do it the old-fashioned way.
multi sub F($n where * > 0 ) { state %c; %c{$n} //= $n - M( F($n-1) ) }
multi sub M($n where * > 0 ) { state %c; %c{$n} //= $n - F( M($n-1) ) }

