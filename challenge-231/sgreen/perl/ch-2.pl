#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@passengers) {
    # Find passengers where their age (fourth and third last digits) >= 60
    my $count = grep { substr( $_, -4, 2 ) >= 60 } @passengers;
    say $count;
}

main(@ARGV);