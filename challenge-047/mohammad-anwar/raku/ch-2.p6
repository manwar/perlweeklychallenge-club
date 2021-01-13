#!/usr/bin/env perl6

use v6.d;

sub MAIN() {

    my $start = 99;
    my $count = 0;

    while $count <= 20 {
        $start++;

        my @d = $start.split("");
        my $divisor = sprintf("%d%d", @d[1].Int, @d[3].Int);

        unless $start % $divisor {
            say sprintf("%d / %d", $start, $divisor);
            $count++;
        }
    }
}
