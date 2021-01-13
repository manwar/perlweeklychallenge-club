#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub digits_sum {
    my ($digits, $sum, $min) = @_;
    return $sum ? () : "" if 0 == $digits;
    $min //= 1;
    my $max = $sum > 9 ? 9 : $sum;
    map {
        my $start = $_;
        map "$start$_", digits_sum($digits - 1, $sum - $start, 0)
    } $min .. $max
}

say for digits_sum(2, 4);

# This takes 5.5 seconds.
# say for digits_sum(7, 42);
