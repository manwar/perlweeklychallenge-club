#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

use JSON;
my $json = JSON->new;

my $array = [ [ 1 .. 3 ], [ 4 .. 6 ], [ 7 .. 9 ] ];

my $a90   = rotate_90($array);
my $a180a = rotate_90($a90);
my $a270a = rotate_90($a180a);
my $a360a = rotate_90($a270a);

my $a180b = rotate_180($array);
my $a270b = rotate_270($array);

say $json->encode($array);
say '';
say $json->encode($a90);
say '';
say $json->encode($a180a);
say $json->encode($a180b);
say '';
say $json->encode($a270a);
say $json->encode($a270b);
say '';
say $json->encode($a360a);

sub rotate_90( $array ) {
    my $x      = -1 + scalar $array->@*;
    my $y      = -1 + scalar $array->[0]->@*;
    my $output = [];
    for my $i ( 0 .. $x ) {
        my $jj = $i;
        for my $j ( 0 .. $y ) {
            my $ii = $y - $j;
            $output->[$i][$j] = int $array->[$ii][$jj];
        }
    }
    return $output;
}

sub rotate_180( $array ) {
    my $x      = -1 + scalar $array->@*;
    my $y      = -1 + scalar $array->[0]->@*;
    my $output = [];
    for my $i ( 0 .. $x ) {
        my $jj = $x - $i;
        for my $j ( 0 .. $y ) {
            my $ii = $y - $j;
            $output->[$i][$j] = int $array->[$ii][$jj];
        }
    }
    return $output;
}

sub rotate_270($array) {
    my $x      = -1 + scalar $array->@*;
    my $y      = -1 + scalar $array->[0]->@*;
    my $output = [];
    for my $i ( 0 .. $x ) {
        my $jj = $x - $i;
        for my $j ( 0 .. $y ) {
            my $ii = $j;
            $output->[$i][$j] = int $array->[$ii][$jj];
        }
    }
    return $output;
}

__DATA__

1 2 3
4 5 6
7 8 9

7 4 1
8 5 2
9 6 3 

so 0,0 = 2,0
   0,1 = 3,0
