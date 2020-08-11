#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

use Carp;
use JSON;

my $json = JSON->new->canonical->allow_nonref;

my $permutation = return_permutation( 3, 4 );
say $json->encode($permutation);

sub return_permutation ( $n, $k ) {
    $n = int $n;
    $k = int $k;
    croak 'n < 1' unless $n >= 1;
    croak 'k < 1' unless $k >= 1;
    my $src->@* = 1 .. $n;
    my @permutations = permute_array($src);
    my @output;

    if ( $permutations[ $k - 1 ] ) {
        push @output, $permutations[ $k - 1 ]->@*;
    }

    return wantarray ? @output : \@output;
}

sub permute_array ( $array ) {
    return $array if scalar $array->@* == 1;
    my @response = map {
        my $i        = $_;
        my $d        = $array->[$i];
        my $copy->@* = $array->@*;
        splice $copy->@*, $i, 1;
        my @out = map { unshift $_->@*, $d; $_ } permute_array($copy);
        @out
    } 0 .. scalar $array->@* - 1;
    return @response;
}
