#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

use constant PI => 4 * atan2(1, 1);

sub mean {
    my @radians = map $_ * 2 * PI / 360, @_;
    atan2(1 / @_ * sum(map sin, @radians),
          1 / @_ * sum(map cos, @radians))
        / 2 / PI * 360
}

use Test::More;
is sprintf('%.3f', mean(0, 0, 90)), 26.565;

