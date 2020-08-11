#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

sub digits_sum {
    my ($digits, $sum) = @_;
    grep $sum == sum(split //), 1 . (0 x ($digits - 1)) .. 9 x $digits
}

say for digits_sum(2, 4);

# This takes 14.5 seconds.
# say for digits_sum(7, 42);
