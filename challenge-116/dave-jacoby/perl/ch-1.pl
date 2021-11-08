#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

my @numbers = qw{ 1234 91011 10203 };

for my $n (@numbers) {
    say base($n);
}

# we are asked to return the sequence 
# or the given number, and accounting 
# for that makes recursion difficult,
# so we pass to base to determine that

sub base ( $n ) {
    my $s = get_sequence($n);
    return $s//$n;
}

# test for success and return if successful
# then add commas within (a copy of) the 
# string

sub get_sequence ( $n ) {
    my $t = test($n);
    return $n if $t;

    my $output;
    my @n = split /,/, $n;
    my $flag = 0;
    map { $flag += 1 if $_ > 10 } @n;
    if ( $flag > 0 ) {
        for my $i ( 0 .. length $n ) {
            my $cp = $n;
            my $l = substr( $cp, $i, 1 );
            substr( $cp, $i, 1 ) = ',' . $l;
            next if $cp =~ m{^\,|\,\,|\,$};
            my $x = get_sequence($cp);
            return $x if $x;
        }
    }
    return undef;
}

sub test ( $n ) {
    my $t = 1;
    my @n = split /,/, $n;
    $t = 0 if $n[0] =~ m{^0}mx;
    $t = 0 if scalar @n < 2;
    for my $i ( 1 .. -1 + scalar @n ) {
        my $h = $i - 1;
        $t = 0 if $n[$i] =~ m{^0}mx;
        $t = 0 unless $n[$h] + 1 == $n[$i];
    }
    return $t;
}
