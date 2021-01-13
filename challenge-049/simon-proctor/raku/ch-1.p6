#!/usr/bin/env perl6

use v6.d;

#| find the first multiple of x made of only 1's and 0's
sub MAIN(
    UInt $x #= Number to look for multiple of
) {
    my @seq = lazy gather {
        my $current = 1;
        loop {
            take $current.base(2);
            $current++;
        }
    }

    @seq.first( * %% $x ).say;
}
