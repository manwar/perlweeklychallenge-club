#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ uniq };

use JSON;
my $json = JSON->new;

my $puzzle = '
 _ _ _ 2 6 _ 7 _ 1 
 6 8 _ _ 7 _ _ 9 _ 
 1 9 _ _ _ 4 5 _ _ 
 8 2 _ 1 _ _ _ 4 _ 
 _ _ 4 6 _ 2 9 _ _ 
 _ 5 _ _ _ 3 _ 2 8 
 _ _ 9 3 _ _ _ 7 4 
 _ 4 _ _ 5 _ _ 3 6 
 7 _ 3 _ 1 8 _ _ _ 
';

my @puzzle;
for my $row ( grep { /\S/ } split /\s?\n\s?/, $puzzle ) {
    my @row = split /\s/mx, $row;
    push @puzzle, \@row;
}

say 'BEFORE';
display_puzzle(@puzzle);
solve_puzzle( 0, 0, \@puzzle );

sub solve_puzzle ( $x, $y, $puzzle ) {
    return unless $puzzle->[$x][$y];
    my $n = $puzzle->[$x][$y];

    my $nx = $x;
    my $ny = $y;
    $nx++;
    if ( $nx > 8 ) {
        $ny++;
        $nx = 0;
    }

    if ( $n eq '_' ) {
        for my $i ( 1 .. 9 ) {
            $puzzle->[$x][$y] = $i;
            next unless test_puzzle($puzzle);
            if ( $x == 8 && $y == 8 ) {
                say 'SOLVED';
                display_puzzle($puzzle->@*);
            }
            else {
                solve_puzzle( $nx, $ny, $puzzle );
            }
        }
        $puzzle->[$x][$y] = '_';
    }
    else {
        solve_puzzle( $nx, $ny, $puzzle );
    }
}

sub test_puzzle( $puzzle) {
    my @puzzle    = $puzzle->@*;
    my $yardstick = join ' ', 1 .. 9;

    # rows
    for my $x ( 0 .. 8 ) {
        my @row = $puzzle[$x]->@*;
        for my $k ( 1 .. 9 ) {
            my @c = grep { /$k/ } @row;
            my $c = scalar @c;
            return 0 if $c > 1;
        }
    }

    # columns
    for my $x ( 0 .. 8 ) {
        my @col = map { $puzzle->[$_][$x] } 0 .. 8;
        for my $k ( 1 .. 9 ) {
            my @c = grep { /$k/ } @col;
            my $c = scalar @c;
            return 0 if $c > 1;
        }
    }

    # blocks
    for my $xa ( 0 .. 2 ) {
        for my $ya ( 0 .. 2 ) {
            my @block;
            for my $xb ( 0 .. 2 ) {
                for my $yb ( 0 .. 2 ) {
                    my $x = $xa * 3 + $xb;
                    my $y = $ya * 3 + $yb;
                    push @block, $puzzle[$x][$y];
                }
            }
            for my $k ( 1 .. 9 ) {
                my @c = grep { /$k/ } @block;
                my $c = scalar @c;
                return 0 if $c > 1;
            }
        }
    }
    return 1;
}

sub display_puzzle ( @puzzle ) {
    say '-' x 27;
    for my $x ( 0 .. 8 ) {
        if ( $x % 3 == 0 && $x ne 0 ) { say ''; }
        for my $y ( 0 .. 8 ) {
            print ' ' if $y % 3 == 0;
            print $puzzle[$x][$y] || '=';
            print ' ';
        }
        say '';
    }
    say '-' x 27;
    say '';
}

