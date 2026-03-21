#!/usr/bin/env perl

# Perl Weekly Challenge 216 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-216/

use Modern::Perl;
use List::Util qw( min sum );

say count_stickers(@ARGV);

sub char_frequency {
    my($word) = @_;
    my %freq;
    for my $ch (split //, $word) {
        $freq{$ch}++;
    }
    return %freq;
}

sub count_stickers {
    my($word, @stickers) = @_;
    my %need = char_frequency($word);

    my $count = 0;

    # loop while chars to satisfy
    while (sum(values %need) > 0) {
        # find best sticker
        my $best_id = -1;
        my $best_match = 0;
        my $best_sticker = "";

        for my $id (0 .. $#stickers) {
            my %have = char_frequency($stickers[$id]);
            my $match = 0;
            for my $ch (keys %need) {
                if (exists $have{$ch}) {
                    $match += min($have{$ch}, $need{$ch})
                }
            }

            if ($match > $best_match) {
                $best_id = $id;
                $best_match = $match;
                $best_sticker = $stickers[$id];
            }
        }

        if ($best_match == 0) {
            return 0;   # no solution
        }

        # subtract have from need
        my %have = char_frequency($best_sticker);
        for my $ch (keys %need) {
            if (exists $have{$ch}) {
                $need{$ch} -= min($have{$ch}, $need{$ch})
            }
        }

        $count++;
    }

    return $count;
}
