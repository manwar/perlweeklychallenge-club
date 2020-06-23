#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

for my $n ( 4 .. 100 ) {
    say join "\t", $n, power_integers($n);
}

sub power_integers( $n = 9 ) {
    my $o = int 1 + sqrt($n);
    if ( $o > 1 ) {
        for my $i ( 2 .. $o ) {
            my $nn = $n;
            my $c  = 0;
            while ( $nn % $i == 0 ) {
                $nn /= $i;
                $c++;
                return join '^', $i, $c if $nn == 1;
            }
        }
    }
    return 0;
}
