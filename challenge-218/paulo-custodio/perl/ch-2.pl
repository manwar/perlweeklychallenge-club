#!/usr/bin/env perl

# Perl Weekly Challenge 218 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-218/

use Modern::Perl;
use List::Util 'sum';

sub compute_score {
    my(@game) = @_;
    return sum(map {oct("0b$_")} @game);
}

sub invert_row {
    my($row, @game) = @_;
    $game[$row] =~ tr/01/10/;
    return @game;
}

sub invert_col {
    my($col, @game) = @_;
    for (@game) {
        $_ = substr($_,0,$col).(1-substr($_,$col,1)).substr($_,$col+1);
    }
    return @game;
}

sub maximize_score {
    my(@game) = @_;
    my $max = compute_score(@game);
    my $changed;
    do {
        $changed = 0;
        for my $row (0..$#game) {
            my @new_game = invert_row($row, @game);
            my $new_max = compute_score(@new_game);
            if ($new_max > $max) {
                @game = @new_game;
                $max = $new_max;
                $changed = 1;
            }
        }
        for my $col (0..length($game[0])-1) {
            my @new_game = invert_col($col, @game);
            my $new_max = compute_score(@new_game);
            if ($new_max > $max) {
                @game = @new_game;
                $max = $new_max;
                $changed = 1;
            }
        }
    } while ($changed);
    return @game;
}

say compute_score(maximize_score(@ARGV));
