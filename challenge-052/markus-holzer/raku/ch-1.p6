# Inspired by Simon
sub is-consecutive( UInt $n ) {
    [==] ^$n.chars Z- $n.comb;
}

sub MAIN (UInt $start = 100, UInt $end = 999) {
    .say for ($start..$end).grep( &is-consecutive );
}