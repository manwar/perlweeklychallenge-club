#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new->space_after;

my @examples;
push @examples, [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], ];

push @examples,
    [ [ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], [ 9, 10, 11, 12 ],
    [ 13, 14, 15, 16 ], ];

for my $example (@examples) {
    my $out->@* = spiral_matrix($example);
    say $json->encode($out);
    say '';
}

sub spiral_matrix( $example ) {
    my @output;
    my $mask = [];
    for my $row ( $example->@* ) {
        push $mask->@*, [ map { 0 } $row->@* ];
    }
    my $i = 0;
    my $x = 0;
    my $y = 0;
    my @move;
    push @move, sub { $y++ };
    push @move, sub { $x++ };
    push @move, sub { $y-- };
    push @move, sub { $x-- };
    my @back;
    push @back, sub { $y-- };
    push @back, sub { $x-- };
    push @back, sub { $y++ };
    push @back, sub { $x++ };

    while (1) {
        push @output, $example->[$x][$y];
        $mask->[$x][$y] = 1;
        my $m = $json->encode($mask);
        my $s = $m =~ /0/ ? 1 : 0;
        last unless $s;
        $move[$i]->();
        if ( !$example->[$x][$y] || $mask->[$x][$y] ) {
            $back[$i]->();
            $i = ( $i + 1 ) % 4;
            $move[$i]->();
        }
    }
    return @output;
}

sub check_mask( $mask ) {
    for my $i ( $mask->@* ) {
        my @z = grep { /0/ } $i->@*;
        return 0 unless scalar @z;
    }
    return 1;
}

