#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum };

use JSON;
my $json = JSON->new;

my $shortest = ' ' x 1000;
my $board    = create_board();

display_board($board);
solve_board($board);
display_board( $board, $shortest );

sub solve_board ( $board, $trail = undef ) {
    $trail //= '00';
    my @trail = map { [ split // ] } split / +/, $trail;
    my ( $i, $j ) = $trail[-1]->@*;

    my $t     = $trail[-1];
    my $score = check_board( $board, $trail );
    if ( $score == 6 ) {
        if ( length $trail < length $shortest ) {
            $shortest = $trail if length $trail < length $shortest;
            display_board( $board, $shortest );
            say join "\n\t", length $shortest, $shortest;
            return $trail;
        }
    }

    for my $im ( -2, 2 ) {
        my $ii = $i + $im;
        next if $ii < 0 || $ii > 7;
        for my $jm ( -1, 1 ) {
            my $jj = $j + $jm;
            next if $jj < 0 || $jj > 7;
            my $tt = "$ii$jj";
            next if $tt eq $t;
            next if $trail =~ /$tt/;
            solve_board( $board, "$trail $tt" );
        }
    }
    for my $im ( -1, 1 ) {
        my $ii = $i + $im;
        next if $ii < 0 || $ii > 7;
        for my $jm ( -2, 2 ) {
            my $jj = $j + $jm;
            next if $jj < 0 || $jj > 7;
            my $tt = "$ii$jj";
            next if $tt eq $t;
            next if $trail =~ /$tt/;
            solve_board( $board, "$trail $tt" );
        }
    }
}

sub check_board ( $board, $trail ) {
    return sum
        map { my ( $i, $j ) = $_->@*; $board->[$i][$j] }
        map { [ split // ] } split / /, $trail;
}

sub create_board {
    my $board;
    for my $i ( 0 .. 7 ) {
        for my $j ( 0 .. 7 ) {
            $board->[$i][$j] = 0;
        }
    }
    $board->[6][0] = 1;
    $board->[5][1] = 1;
    $board->[6][1] = 1;
    $board->[7][1] = 1;
    $board->[4][2] = 1;
    $board->[2][4] = 1;
    return $board;
}

sub display_board ( $board, $trail = '' ) {
    my @i = reverse 1 .. 8;
    say '';
    say $trail;
    say join ' ', ' ', 'a' .. 'h';
    for my $i ( 0 .. 7 ) {
        print $i[$i];
        for my $j ( 0 .. 7 ) {
            my $tt = "$i$j";
            if ( $trail =~ $tt ) {
                print $board->[$i][$j] ? ' X' : ' .';
            }
            else {
                print $board->[$i][$j] ? ' x' : ' *';
            }
        }
        say ' ' . $i[$i];
    }
    say join ' ', ' ', 'a' .. 'h';
    say '';
}
