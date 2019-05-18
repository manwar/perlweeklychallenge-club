#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util qw(max);

print center(<>);

sub center {
    my @lines = @_;

    my $max = max map {length} @lines;

    return map {' ' x (($max - length) / 2) . $_} @lines;
}
