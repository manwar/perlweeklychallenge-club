#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{ max };

my $n = 1;
my @self_desc;

while ( scalar @self_desc < 3 ) {
    if ( is_self_descriptive($n) ) {
        push @self_desc, $n;
        say join ' ', @self_desc;
    }
    $n++;
    exit if $n > 1_000_000_000;
}

sub is_self_descriptive ( $n ) {
    my $max = max split m{}, $n;
    my $l   = -1 + length $n;
    return 0 if $max > $l;

    my @arr;
    for my $i ( 0 .. -1 + length $n ) { $arr[$i] = 0 }
    for my $i ( split m{|}, $n ) {
        $arr[$i]++;
    }
    my $r = 0 + ( join '', map { $_ || 0 } @arr );
    return 0 if $r != $n;
    return 1;
}

say join "\n\t", scalar @self_desc, @self_desc;

