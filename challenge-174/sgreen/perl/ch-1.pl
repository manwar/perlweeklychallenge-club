#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_disarium ($n) {
    my $sum = 0;

    foreach my $count ( 1 .. length($n) ) {
        $sum += substr( $n, $count - 1, 1 )**$count;
    }

    return $sum == $n;
}

sub main {
    my @solutions = ();
    my $number    = 0;

    while ( scalar(@solutions) < 19 ) {
        if ( is_disarium($number) ) {
            push @solutions, $number;
        }
        $number++;
    }

    say join ', ', @solutions;
}

main();
