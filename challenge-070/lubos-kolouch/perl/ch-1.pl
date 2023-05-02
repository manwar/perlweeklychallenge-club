#!/usr/bin/perl
use strict;
use warnings;

my $S = 'perlandraku';
my $C = 3;
my $O = 4;
my $N = length($S);

for my $i ( 1 .. $C ) {
    my $x = $i % $N;
    my $y = ( $i + $O ) % $N;
    substr( $S, $x, 1, substr( $S, $y, 1, substr( $S, $x, 1 ) ) );
}

print "$S\n";
