#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@ints) {
    my $element_sum = sum(@ints);
    my $digit_sum   = sum( map { split // } @ints );
    say abs( $element_sum - $digit_sum );
}

main(@ARGV);