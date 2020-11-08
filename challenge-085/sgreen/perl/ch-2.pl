#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub main {
    my $target = shift;
    die "The value '$target' is not a positive integer"
      unless $target =~ /^[1-9][0-9]*$/;

    my $power = 2;
    while (1) {
        my $number  = $target**( 1 / $power );
        my $rounded = sprintf '%.0f', $number;
        if ( $rounded**$power == $target ) {
            # We have a solution.
            say "Output: 1 as $target = $number ^ $power";
            return;
        }
        elsif ( $number < 2 ) {
            # No solution is possible
            say 'Output: 0';
            return;
        }

        $power++;
    }

    return;
}

main(@ARGV);

