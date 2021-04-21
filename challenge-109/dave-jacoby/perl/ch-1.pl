#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{sum0};

my @test = ( 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21 );

say join ', ', @test;
say join ', ', map { chowla($_) } 1 .. 20;
say join ', ', map { chowla2($_) } 1 .. 20;

# the old-fashioned for-loop way
sub chowla ( $n ) {
    my $c = 0;
    for my $i ( 1 .. $n ) {
        my $m = $n % $i;
        next     if $i == 1 || $i == $n;
        $c += $i if $m == 0;
    }
    return $c;
}

# the new, hot functional approach
# using sum0 because if given an empty list, 
# sum0 returns zero instead of undef
sub chowla2 ( $n ) {
    return sum0
        grep { $n % $_ == 0 }
        grep { $_ != 1 }
        grep { $_ != $n } 1 .. $n;
}
