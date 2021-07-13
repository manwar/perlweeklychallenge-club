#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{sum0};

my $n   = 0;
my $map = [ [ 0, 5, 2, 7 ], [ 5, 0, 5, 3 ], [ 3, 1, 0, 6 ], [ 4, 5, 4, 0 ], ];

GetOptions( 'n=i' => \$n, );
croak q{N out of range} if $n > 20 || $n < 0;

if ( $n > 0 ) {
    $map = build_random_map($n);
}

my @final_tour;
my $f = 1000000;
travelling_salesman($map);
my $tour = join ' ', @final_tour;

say <<"END";
    length: $f
    tour:   $tour
END

say join "\n", '', map { join ' ', $_->@* } $map->@*;

sub travelling_salesman ( $map, $loc = 0, $tour = [] ) {
    push $tour->@*, $loc;
    my $l = tour_length( $map, $tour );
    return unless $l < $f;

    my %tour    = map  { ( $_, 1 ) } $tour->@*;
    my @options = grep { !$tour{$_} } 0 .. -1 + scalar $map->@*;

    if ( scalar @options ) {
        for my $o (@options) {
            my $next->@* = $tour->@*;
            travelling_salesman( $map, $o, $next );
        }
    }
    else {
        push $tour->@*, $tour->[0];
        my $l = tour_length( $map, $tour );
        say join ' ', 'END', $l, '', $f, '', $tour->@*;
        if ( $l < $f ) {
            @final_tour = $tour->@*;
            $f          = $l;
        }
    }
}

sub tour_length ( $map, $tour ) {
    my $n = -1 + scalar $map->@*;
    my @dist;
    for my $i ( 0 .. $n ) {
        my $j = $i + 1;
        next unless $tour->[$i];
        next unless $tour->[$j];
        my $x = $tour->[$i];
        my $y = $tour->[$j];
        my $d = $map->[$x][$y];
        push @dist, $d;
    }
    return sum0 @dist;
}

sub build_random_map ( $n ) {
    my $output = [];
    for my $i ( 0 .. -1 + $n ) {
        for my $j ( $i .. -1 + $n ) {
            my $r = 1 + int rand 9;
            $output->[$i][$j] = $r;
            $output->[$j][$i] = $r;
            $output->[$i][$j] = 0 if $i == $j;
        }
    }
    return $output;
}
