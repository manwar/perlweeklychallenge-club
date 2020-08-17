#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ first };
use JSON;
my $json = JSON->new->pretty->canonical;

my @strings = qw{
    ababc
    xyzzyx
};

for my $string (@strings) {
    my $output = fnr($string);
    say qq{Input:   $string};
    say qq{Output:  $output};
    say '';
}

sub fnr ( $s ) {
    my @output;
    my @done;
    for my $i ( 0 .. length $s ) {
        my $l = substr( $s, $i, 1 );
        push @done, $l;
        my %hash;
        map { $hash{$_}++ } @done;
        my $o = '#';
        for my $m ( reverse @done ) {
            if ( $hash{$m} < 2 ) { $o = $m; last }
        }
        push @output, $o;

    }
    return join '', @output;
    return uc $s;
}
