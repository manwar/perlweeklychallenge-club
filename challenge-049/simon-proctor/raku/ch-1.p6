#!/usr/bin/env perl6

use v6.d;

#| find the first multiple of x made of only 1's and 0's
sub MAIN(
    UInt $x #= Number to look for multiple of
) {
    my $current = 1;
    my $current-bin = $current.base(2);

    while ( ! ( $current-bin %% $x ) ) {
        $current++;
        $current-bin = $current.base(2);
    }

    say $current-bin;
}
