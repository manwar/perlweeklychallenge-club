#!/usr/bin/env perl

# The Weekly Challenge 267 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/
#
# Task 2 - Line Counts
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @example_lines = ("abcdefghijklmnopqrstuvwxyz", "bbbcccdddaaa");

my @example_widths =(
        [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10],
        [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10],
    );

sub line_counts {
    my $line = shift;
    my $widths = shift;
    my $len = length $line;
    my $width_sum = 0; 
    my $line_counter = 0;
    my $ord_a = ord('a');

    for (my $i = 0; $i < $len; $i++) {
       my $letter = ord(substr($line,$i,1)) - $ord_a;

       if ($width_sum + @$widths[$letter] <= 100) {
           $width_sum += @$widths[$letter]
       }else {
            $line_counter++;
            $width_sum = @$widths[$letter];
       }
    }
       
    $line_counter++ if ($width_sum);

    return [$line_counter, $width_sum];
}

for (my $i = 0; $i < scalar @example_lines; $i++) {
    my $line = $example_lines[$i];
    my $width = $example_widths[$i];
    my $lc = line_counts $line, $width;

    $Data::Dump::LINEWIDTH = 100;
    say 'Input : @str = ', $line;
    say '     @widths = ', dump(@$width);
    say 'Output : ', dump(@$lc);
    say ' ';
}
