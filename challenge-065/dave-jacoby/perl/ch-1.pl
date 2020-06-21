#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use Getopt::Long;
use List::Util qw{sum};

my $N = 0;
my $S = 0;

GetOptions(
    'n=i' => \$N,
    's=i' => \$S,
);

$N = $N > 0 ? $N : 2;
$S = $S > 0 ? $S : 4;

my @output = digit_sums( $N, $S );
say join ', ', @output;

sub digit_sums ( $N, $S ) {
    my @output;
    my $start = 1;
    while ( length $start < $N ) { $start .= '0' }
    my $end = '9' x $N;
    for my $i ( $start .. $end ) {
        my $sum = sum split //, $i;
        push @output, $i if $sum == $S;
    }
    return @output;
}
