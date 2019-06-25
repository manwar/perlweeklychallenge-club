#!/usr/bin/env perl6

use v6;

#| Generate Van Eck's sequence
sub MAIN (
    UInt $count, #= Amount of sequence to generate
    UInt $start = 0 # Value to start sequnce from
) {

    my @van-ecks = lazy gather {
        take $start;
        my $n = 0;
        loop {
            if any( @van-ecks[^$n] ) == @van-ecks[$n] {
                my $m;
                for @van-ecks[^$n].kv.reverse -> $v, $k {
                    if $v == @van-ecks[$n] {
                        $m = $k;
                        last;
                    }
                }
                take $n - $m;
            } else {
                take 0;
            }
            $n++;
        }
    }

    say @van-ecks[0..^$count].join(",");

}
