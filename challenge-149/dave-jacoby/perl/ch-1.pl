#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Getopt::Long;
use List::Util qw{ sum0 max };

my $N = 20;
GetOptions( 'n=i' => \$N, );

my @fib = first_60_fib();
my %fib = map { $_ => 1 } @fib;
my @x;

my $n = 0;
while ( scalar @x < $N ) {
    my $sd = sum_of_digits($n);
    my $f  = $fib{$sd} || 0;
    push @x, $n if $f;
    $n++;
}
say join ' ', @x;

sub first_60_fib() {
    my @n;
    push @n, 0;
    push @n, 1;
    while ( scalar @n < 60 ) {
        push @n, $n[-1] + $n[-2];
    }
    return @n;
}

sub sum_of_digits ( $n ) {
    return sum0 split //, $n;
}
