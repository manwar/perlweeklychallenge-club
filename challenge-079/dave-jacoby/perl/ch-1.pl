#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use List::Util qw{ sum };
use Getopt::Long;

my $n = 4;
GetOptions( 'n=i' => \$n, );
croak 'Non-positive number' if $n < 0;

my $total = count_set_bits($n);
say $total;

sub count_set_bits( $n ) {
    my $total = 0;
    my $t     = 0;
    for my $i ( 0 .. $n ) {
        my $b = sprintf '%b', $i;
        my $c = sum split m{|}, $b;
        $total += $c;
        $t = $total % 1000000007;
    }

    return $t;
}
