#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'all';

sub main ($input_string) {
    my %freq = ();
    for my $char ( split //, $input_string ) {
        $freq{$char}++;
    }

    my $all_odd = all { $_ % 2 == 1 } values %freq;
    say $all_odd ? "true" : "false";
}

main( $ARGV[0] );
