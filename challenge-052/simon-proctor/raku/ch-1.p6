#!/usr/bin/env raku

use v6;

sub is-consecutive( UInt $number ) {
    my @test = $number.comb();
    [==] ((@test.elems,*-1...0) Z+ @test)
}

#| Give all the stepping mnumbers between start and end
sub MAIN (
    UInt $start where { $_ >= 100 } = 100, # Start value defaults to 100
    UInt $end where { $_ >= $start } = 999, # End value default to 999
) {
    .say for ($start..$end).hyper.grep( &is-consecutive )
}
