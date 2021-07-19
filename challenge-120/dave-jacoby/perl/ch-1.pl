#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

for my $n ( 18, 101 ) {
    say join "\t", '', $n, swap_bits($n);
}

sub swap_bits ($n) {
    my $b = sprintf '%08b', $n;
    my $r = join '', map { scalar reverse($_) } ( $b =~ /../g );
    my $s = oct( '0b' . $r );
    return $s;
}
