#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $m, $n ) = @_;
    my $l       = length($m);
    my $matches = 0;

    # Get all combinations
    for my $i ( 1 .. 2**$l - 2 ) {
        my $number = join '', map { substr( $m, $_, 1 ) } grep { $i & 2**$_ } ( 0 .. $l - 1 );
        $matches++ if $number % $n == 0;
    }

    say $matches;
}

main(@ARGV);
