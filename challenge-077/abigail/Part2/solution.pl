#!/opt/perl/bin/perl

#
# Exercise:
#    You are given m x n character matrix consists of O and X only.
#    Write a script to count the total number of X surrounded by O only.
#    Print 0 if none found.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Read in the board. Use 1 for an X, and 0 for an 0. Add a band
# of 0's around the board.
#

my      @board = map {[0, map ({/O/ ? 0 : 1} /[OX]/g), 0]} <>;
push    @board => [(0) x @{$board [0]}];
unshift @board => [(0) x @{$board [0]}];

my $count = 0;

#
# Iterate over the cells of the board board, skipping cells on the edge
# (as we added them). For each 1, check the 8 cells surrounding the cell
# (this will never be outside of the board). If one of the neighbouring
# cells is a 1, move on the next cell. If no neighbouring cell is 1,
# we add 1 to the count.
#
for (my $x = 1; $x < @board - 1; $x ++) {
  ELEMENT:
    for (my $y = 1; $y < @{$board [$x]} - 1; $y ++) {
        next unless $board [$x] [$y];
        foreach my $dx (-1 .. 1) {
            foreach my $dy (-1 .. 1) {
                next unless $dx || $dy;
                next ELEMENT if $board [$x + $dx] [$y + $dy];
            }
        }
        $count ++;
    }
}

#
# Print solution.
#
say $count;

__END__
