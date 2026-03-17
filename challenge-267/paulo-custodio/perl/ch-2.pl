#!/usr/bin/env perl

# Perl Weekly Challenge 267 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/

use Modern::Perl;

my $LINE_WIDTH = 100;

my($str, @widths) = @ARGV;
say "(", join(", ", line_counts($str, @widths)), ")";

sub line_counts {
    my($str, @widths) = @_;
    my $lines = 1;
    my $col = 0;
    for my $ch (split //, $str) {
        my $width = $widths[ord($ch)-ord('a')];
        if ($col + $width > $LINE_WIDTH) {
            $lines++;
            $col = 0;
        }
        $col += $width;
    }
    return ($lines, $col);
}
