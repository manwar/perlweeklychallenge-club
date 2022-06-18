#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my $iter = make_iterator(2);
my @achilles;

while ( my $i = $iter->() ) {
    next if is_achilles($i) == 0;
    push @achilles, $i;
    last if scalar @achilles >= 20;
}

say join ', ', @achilles;
exit;

sub is_achilles( $n ) {
    return 0 if is_prime($n);
    return 0 if !is_powerful($n);
    return 0 if is_perfect($n);
    return 1;
}

sub is_perfect( $n ) {
    for my $i ( 2 .. $n ) {
        my $j = $n**( 1 / $i );
        return 1 if ( $j =~ /^-?\d+$/ ) ;
    }
    return 0;
}

sub is_powerful($n) {
    my @factors = get_factors($n);
    my %factors;
    map { $factors{$_}++ } @factors;
    for my $f ( keys %factors ) {
        return 0 if $factors{$f} < 2;
    }
    return 1;

}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}

sub get_factors( $n ) {
    my @factors;
    for my $i ( 2 .. $n ) {
        next unless $n % $i == 0;
        while ( $n % $i == 0 ) {
            push @factors, $i;
            $n = $n / $i;
        }
    }
    return @factors;
}

sub make_iterator($n) {
    return sub {
        state $v = $n;
        return $v++;
    }
}

