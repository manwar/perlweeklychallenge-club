#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use constant pi => 3.14159;

my $clear  = '  ';
my $filled = ' #';

my @venus;
for my $i ( 0 .. 50 ) {
    for my $j ( 0 .. 40 ) {
        $venus[$i][$j] = $clear;
    }
}
my $maxx = 0;
for my $d ( 0 .. 360 ) {
    my $r   = deg2rad($d);
    my $len = 11;
    my $x   = 19 + int xPos( $len, $r );
    my $y   = 19 - int yPos( $len, $r );
    $venus[$x][$y] = $filled;
    $maxx = $x > $maxx ? $x : $maxx;
}

for my $i ( 0 .. 10 ) {
    $venus[ $maxx + $i ][19] = $filled;
    $venus[ $maxx + 5 ][ 24 - $i ] = $filled;

}

for my $row (@venus) {
    say join '', $row->@*;
}

sub deg2rad ($degrees) {
    return ( $degrees / 180 ) * pi;
}

sub xPos ( $len = 10, $rad = 0 ) {
    return $len * sin $rad;
}

sub yPos ( $len = 10, $rad = 0 ) {
    return $len * cos $rad;
}
