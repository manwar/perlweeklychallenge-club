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

# iterative solution
sub waves ( $array ) {
    my $copy->@* = map { $_ } $array->@*;
    my $bitflip = 1;
    my @output;
    while ( scalar $copy->@* > 1 ) {
        if ( $bitflip  && $copy->[0] < $copy->[1] ) { return 0 }
        if ( !$bitflip && $copy->[0] > $copy->[1] ) { return 0 }
        shift $copy->@*;
        $bitflip = int !$bitflip;
    }
    return 1;
}

# iterative solution
sub display ( $array ) {
    my $copy->@* = map { $_ } $array->@*;
    my $bitflip  = 1;
    my $output   = '';
    while ( scalar $copy->@* > 1 ) {
        my $sign = $bitflip ? '>=' : '<=';
        $output .= shift $copy->@*;
        $output .= qq{ $sign };
        $bitflip = int !$bitflip;
    }
    $output .= shift $copy->@*;
    return $output;
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
