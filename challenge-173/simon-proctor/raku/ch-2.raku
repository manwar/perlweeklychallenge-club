#!/usr/bin/env raku

#| Print the first $n values in Sylvesters sequence
sub MAIN( UInt $n = 10 ) {
    my @seq = lazy gather {
        take 2;
        take 3;
        my $accum = 6;
        my $next = 7;
        loop {
            take $next;
            $accum *= $next;
            $next = $accum+1;
        }
    };
    .say for @seq[^$n];
}
