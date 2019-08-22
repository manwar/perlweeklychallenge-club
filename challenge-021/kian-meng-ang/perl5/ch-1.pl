#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say signatures);
no warnings qw(experimental::signatures);

# See https://en.wikipedia.org/wiki/E_(mathematical_constant)
sub euler_number ($n) {
    return (1 + 1 / $n) ** $n;
}

say euler_number(1_000_000);

1;
