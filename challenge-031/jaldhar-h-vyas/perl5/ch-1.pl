#!/usr/bin/perl
use 5.010;
use warnings;
use strict;
use English qw/ -no_match_vars /;

sub isDividedByZero {
    my ($numerator, $denominator) = @_;

    eval { $_ = $numerator / $denominator; };

    if ($EVAL_ERROR =~ /division by zero/ms) {
        return 1;
    }

    return undef;
}
