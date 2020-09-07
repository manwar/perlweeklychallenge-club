#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
#              Task 2 - Word Search
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;
use File::Slurp;
use feature qw/say/;


sub get_words {
    my ($grid, $words, $min_count)  = @_;


    # load the grid into 2D array
    my @real_grid;

    my $x_size = scalar @$grid - 1;
    my $y_size;

    for my $i (0..scalar @$grid -1) {
        my $pos = 0;
        for (split / /, $grid->[$i]) {
            $real_grid[$i][$pos] = $_;
            $pos++;
        }
        $y_size = $pos;
    }

    $y_size--;

    # let's construct a big string of all possible combinations

    my $big_string;
    # add all rows
    for my $x (0..$x_size) {
        for my $y (0..$y_size) {
            $big_string .= $real_grid[$x][$y];
        }
        # at the end of row we need a break
        $big_string .= '_';
    }

    # add all columns
    for my $y (0..$y_size) {
        for my $x (0..$x_size) {
            $big_string .= $real_grid[$x][$y];
        }
        $big_string .= '_';
    }

    # add diagonal 1
    for my $x (0..$x_size) {
        for my $y (0..$y_size) {
            last if $x + $y > $x_size;
            $big_string .= $real_grid[$x+$y][$y];
        }
        $big_string .= '_';
    }

    # add diagonal 2
    for my $y (0..$y_size) {

        for my $x (0..$x_size) {
            last if $x + $y > $y_size;
            $big_string .= $real_grid[$x][$y+$x];
        }
        $big_string .= '_';
    }

    # add diagonal 3
    for my $x (0..$x_size) {
        for my $y (0..$y_size) {
            last if $x + $y > $x_size;
            $big_string .= $real_grid[$x+$y][$y_size - $y];
        }
        $big_string .= '_';
    }

    # add diagonal 4
    for my $y (0..$y_size) {
        for my $x (0..$x_size) {
            last if $x + $y > $y_size;
            $big_string .= $real_grid[$x][$y_size - $y - $x];
        }
        $big_string .= '_';
    }

    $big_string .= reverse $big_string;


    my $count = 0;

    for (@$words) {
        next unless length($_) >= $min_count;
        $count++ if index($big_string, uc($_)) != -1;
    }

    return $count;
}

my ($grid_file, $words_file) = @ARGV;

my $grid_ref = read_file($grid_file, array_ref => 1, chomp => 1);
my $words_ref = read_file($words_file, array_ref => 1, chomp => 1);

use Test::More;

is (get_words(['AA','BB'],['AA', 'BB', 'CC'],2), 2);

done_testing;
