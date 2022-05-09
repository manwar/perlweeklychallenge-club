#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use JSON;
my $json = JSON->new->canonical;

my @tests;
push @tests,
    [
    'playfair example',
    'hide the gold in the tree stump',
    'bmodzbxdnabekudmuixmmouvif'
    ];
push @tests,
    [ 'perl and raku', 'the weekly challenge', 'siderwrdulfipaarkcrw' ];

for my $test (@tests) {
    my ( $key, $plain, $cypher ) = $test->@*;
    my @square = make_playfair_square($key);
    my $c1     = encrypt( $key, $plain );
    my $p1     = decrypt( $key, $cypher );
    say join "\n\t", $key, $plain, $c1, $cypher, $p1,
        $cypher eq $c1 ? 'true' : 'false';
    say '';
}
exit;

sub encrypt ( $key, $plaintext ) {
    my @square = make_playfair_square($key);
    my @input  = make_digrams($plaintext);
    my @output;
    for my $digram (@input) {
        my ( $m,  $n )  = split //, $digram;
        my ( $mx, $my ) = find_position( $m, @square );
        my ( $nx, $ny ) = find_position( $n, @square );
        if    (0) { 'NO-OP' }
        elsif ( $mx == $nx ) {
            my $mm = $square[$mx][ ( $my + 1 ) % 5 ];
            my $nn = $square[$nx][ ( $ny + 1 ) % 5 ];
            push @output, $mm . $nn;
        }
        elsif ( $my == $ny ) {
            my $mm = $square[ ( $mx + 1 ) % 5 ][$my];
            my $nn = $square[ ( $nx + 1 ) % 5 ][$ny];
            push @output, $mm . $nn;
        }
        else {
            my $mm = $square[$mx][$ny];
            my $nn = $square[$nx][$my];
            push @output, $mm . $nn;
        }
    }
    my $zed = '';
    return lc join '', @output;
}

sub decrypt ( $key, $cyphertext ) {
    my @square = make_playfair_square($key);
    my @input  = make_digrams($cyphertext);
    my @output;
    for my $digram (@input) {
        my ( $m,  $n )  = split //, $digram;
        my ( $mx, $my ) = find_position( $m, @square );
        my ( $nx, $ny ) = find_position( $n, @square );
        if    (0) { 'NO-OP' }
        elsif ( $mx == $nx ) {
            my $mm = $square[$mx][ ( $my + 4 ) % 5 ];
            my $nn = $square[$nx][ ( $ny + 4 ) % 5 ];
            push @output, $mm . $nn;
        }
        elsif ( $my == $ny ) {
            my $mm = $square[ ( $mx + 4 ) % 5 ][$my];
            my $nn = $square[ ( $nx + 4 ) % 5 ][$ny];
            push @output, $mm . $nn;
        }
        else {
            my $mm = $square[$mx][$ny];
            my $nn = $square[$nx][$my];
            push @output, $mm . $nn;
        }
    }
    my $zed = '';
    return lc join '', @output;
}

sub make_playfair_square( $key ) {
    my %h;
    my @array = grep { !$h{$_}++ } grep { /\w/ } ( split //, lc $key ),
        'a' .. 'i', 'k' .. 'z';
    @array = @array[ 0 .. 24 ];
    my @square;
    for my $i ( 0 .. 24 ) {
        my $x = $i % 5;
        my $y = int $i / 5;
        $square[$y][$x] = uc $array[$i];
    }
    return @square;
}

sub make_digrams ( $text ) {
    my @digrams;
    my $pt = $text;
    $pt =~ s/[jJ]/i/gmix;
    $pt =~ s/[^A-Za-z]+//gmix;
    while ($pt) {
        my $digram = substr( $pt, 0, 2 );
        if ( substr( $digram, 0, 1 ) eq substr( $digram, 1, 1, ) ) {
            $digram = substr( $pt, 0, 1 ) . 'X';
            substr( $pt, 0, 1 ) = '';
        }
        else { substr( $pt, 0, 2 ) = ''; }
        $digram .= 'X' unless length $digram == 2;
        push @digrams, uc $digram;
    }
    return @digrams;
}

sub find_position ( $letter, @square ) {
    exit unless $letter =~ /[A-Z]/mix;
    $letter = uc $letter;
    for my $x ( 0 .. 4 ) {
        for my $y ( 0 .. 4 ) {
            my $s = $square[$x][$y] || '-';
            return ( $x, $y ) if $letter eq $s;
        }
    }
    return ( -1, -1 );
}
