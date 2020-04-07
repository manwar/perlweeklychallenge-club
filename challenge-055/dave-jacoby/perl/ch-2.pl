#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

for my $n ( 1 .. 4 ) {
    for my $arr ( permute_array( [ 1 .. $n ] ) ) {
        say display($arr) if waves($arr);
    }
}

exit;

# Arrayrefs because ease of use.
# Experimental signatures for the same reason.
# Using $bitflip = 1 allows me to ignore that
# for the original call and have the function
# handle it for the rest.
# !$bool gives you 1 or '', so to force to 1 or 0
# we cast as int.

# bitflip 1 means >=
# bitflip 0 means <=

sub waves ( $array, $bitflip = 1 ) {
    if ( scalar $array->@* == 1 )                 { return 1 }
    if ( $bitflip && $array->[0] < $array->[1] )  { return 0 }
    if ( !$bitflip && $array->[0] > $array->[1] ) { return 0 }
    my $array2->@* = map { $_ } $array->@*;
    shift $array2->@*;
    return waves( $array2, int !$bitflip );
    return 1;
}

# display behaves much the same as waves

sub display ( $array, $bitflip = 1 ) {
    if ( scalar $array->@* == 1 ) { return $array->[0] }
    my $sign       = $bitflip ? '>=' : '<=';
    my $array2->@* = map { $_ } $array->@*;
    my $n          = shift $array2->@*;
    return qq{$n $sign } . display( $array2, int !$bitflip );
}

# Return of the permute_array function! Recursion!
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
