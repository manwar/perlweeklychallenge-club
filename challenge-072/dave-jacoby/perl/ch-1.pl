#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ reduce };

my $n = 4;
GetOptions( 'n=i' => \$n, );
croak 'n must be positive' if $n < 1;
croak 'n must be less than 11' if $n > 10;

my $f = factorial($n);
my $t = trailing($f);

my $zero = 'zero';
$zero = 'zeroes' if $t > 1;

say qq{Output: $n as N! = $f has $t trailing $zero};

sub trailing( $f ) {
    my ($z) = $f =~ /(0+)$/mix;
    return length $z || 0;
}

sub factorial ( $n ) {
    return reduce { $a * $b } 1 .. $n;
}
