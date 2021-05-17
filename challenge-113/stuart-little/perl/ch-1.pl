#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <number> <digit>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub lastDigSumm($nr,$dig,$nrSummands) {
    return (($nr - $nrSummands * $dig) % 10 == 0) && ($nrSummands * $dig <= $nr) && ($nrSummands * (($dig -1) * 10 + $dig) >= $nr);
}

sub lastDig($nr,$dig) {
    return !!(grep {lastDigSumm($nr,$dig,$_)} (1..9));
}

sub sol($nr,$dig) {
    $dig == 0 && return ($nr >= 101 || ($nr % 10 == 0));
    return (($nr >= $dig * 11) || lastDig($nr,$dig));
}

say 0+sol(@ARGV);
