#!/usr/local/bin/perl
#
# solve-wordsearch - search for words (from a word list) in a wordsearch grid
#
use strict;
use warnings;
use v5.20;
use feature       qw/ signatures /;
no warnings       qw/ experimental::signatures /;
use File::Slurper qw/ read_lines /;

die "usage: $0 <grid-file> <word-list>\n" unless @ARGV == 2;

my @grid      = map { [split('',lc($_))] } read_lines($ARGV[0]);
my %is_a_word = map { lc($_) => 1        } read_lines($ARGV[1]);
my $num_cols  = int(@{ $grid[0] });
my $num_rows  = int(@grid);
my %found;

scan_grid_for_words();
print_words();

sub scan_grid_for_words {
    for (my $row = 0; $row < $num_rows; ++$row) {
        for (my $col = 0; $col < $num_cols; ++$col) {
            foreach my $row_delta (-1, 0, 1) {
                foreach my $col_delta (-1, 0, 1) {
                    next if $row_delta == 0 && $col_delta == 0;
                    scan_line_for_words($row, $col, $row_delta, $col_delta);
                }
            }
        }
    }
}

sub scan_line_for_words ($row, $col, $row_delta, $col_delta) {
    my $word = "";

    while (on_grid($row,$col)) {
        $word .= $grid[$row][$col];
        $found{$word}++ if $is_a_word{$word};
        $row += $row_delta;
        $col += $col_delta;
    }
}

sub on_grid ($row, $col) {
    return ($row < $num_rows && $row >= 0 && $col >= 0 && $col < $num_cols);
}

sub print_words {
    print "$_\n" for sort keys %found;
}
