#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;

my $k = 16;
my $n = 2;

GetOptions(
    'n=i' => \$n,
    'k=i' => \$k,
);

$n = abs int $n;
$k = abs int $k;

croak 'Zero in input' unless ( $n * $k ) > 0;

my $v = nth_root( $n, $k );
say qq{${n}th root of $k = $v};

# Logarithmic calculation
# r = b ** ( 1/n logb k )
sub nth_root ( $n, $k ) {
    return 10**( ( 1 / $n ) * log10($k) );
}

# https://perldoc.perl.org/functions/log
sub log10 {
    my $n = shift;
    return log($n) / log(10);
}
