#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 product };

@ARGV = ( 123, 145 ) unless scalar @ARGV;

for my $i (@ARGV) {
    my $f = is_factorion($i);
    say join "\t", '', $i, $f;
}

sub is_factorion ( $n ) {
    my $f = factorion($n);
    return $f == $n ? 1 : 0;
}

sub factorion ( $n ) {
    return sum0 map { factorial($_) } split //, $n;
}

sub factorial ( $n ) {
    return 1 if $n == 0;
    state $factorials ;
    if ( !$factorials->{$n} ) {
        $factorials->{$n} = product 1 .. $n;
    }
    return $factorials->{$n};
}
