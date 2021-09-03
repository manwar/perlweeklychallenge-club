#!/usr/bin/env perl

use strict ;
use warnings ;
use feature qw{ say postderef signatures state } ;
no warnings qw{ experimental } ;

use JSON ;
my $json = JSON->new->space_after->utf8 ;

my $field = <<END;
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
END

my @field = map { [ split /\s/, $_ ] }
    split /\n/, $field ;

my $h = -1 + scalar @field ;
my $w = -1 + scalar $field[ 0 ]->@* ;

my @map ;

for my $i ( 0 .. $h ) {
    for my $j ( 0 .. $w ) {
        $map[ $i ][ $j ] = $field[ $i ][ $j ] eq 'x' ? 'x' : 0 ;
        }
    }

for my $i ( 0 .. $h ) {
    for my $j ( 0 .. $w ) {
        next unless $map[ $i ][ $j ] eq 'x' ;
        for my $x ( -1 .. 1 ) {
            for my $y ( -1 .. 1 ) {
                my $xx = $i + $x ;
                my $yy = $j + $y ;
                next if $xx == 0 && $yy == 0 ;
                next if $xx < 0 ;
                next if $yy < 0 ;
                next if $xx > $h ;
                next if $yy > $w ;
                next if $map[ $xx ][ $yy ] eq 'x' ;
                $map[ $xx ][ $yy ]++ ;
                }
            }
        }
    }
show_map( \@map ) ;

sub show_map ( $ref ) {
    say '-' x 20 ;
    say join "\n", map { join ' ', $_->@* } $ref->@* ;
    say '-' x 20 ;
    say '' ;
    }

