#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main(@array) {
    my %score_to_place = ();
    my @sorted = sort { $b <=> $a } @array;
    while(my ($i, $score) = each(@sorted)) {
        if (not exists $score_to_place{$score}) {
            $score_to_place{$score} = $i+1;
        }
    }

    my %place_to_word = ( 1 => 'G', 2 => 'S', 3 => 'B' );
    my @solution = ();
    foreach my $score (@array) {
        my $place = $score_to_place{$score};
        push @solution, $place_to_word{$place} || $place;
    }

    say join ', ', @solution;
}

main(@ARGV);