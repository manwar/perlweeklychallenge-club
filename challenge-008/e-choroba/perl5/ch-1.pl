#!/usr/bin/perl
use warnings;
use strict;

use Path::Tiny;
use List::Util qw{ max };

sub center {
    my @lines = @_;
    my $max_length = max(map length, @lines);
    return map +(' ' x (($max_length - length) / 2)) . $_, @lines
}

my @lines = path(shift)->lines;
print for center(@lines);
