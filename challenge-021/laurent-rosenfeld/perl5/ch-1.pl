#!/usr/bin/perl
use strict;
use warnings;
use feature qw /say signatures/;
no warnings 'experimental::signatures';

sub fact ($n) {
    my $fact = 1;
    $fact *= $_ for 2..$n;
    return $fact;
}
sub eul ($n) {
    my $euler;
    $euler += 1 / fact $_ for 0..$n;
    return $euler;
}

say eul shift;
