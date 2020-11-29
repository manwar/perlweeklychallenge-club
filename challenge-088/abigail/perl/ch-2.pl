#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# You are given m x n matrix of positive integers.
# 
# Write a script to print spiral matrix as list.
# 

#
# We solve this by keeping track of the boundaries (min_x, min_y, max_x,
# max_y) of the part of the matrix which still needs to be processed.
# Initially, min_x and min_y are 0, max_x is the index of the bottom row,
# and max_y is the index of the right most column.
#
# We then process the matrix side by side, first going east (top row), 
# south (left column), west (bottom row), then north (left row). After
# doing a side, we update the corresponding min/max value. That is,
# after doing the top row, we increment $min_x; right column, decrement
# $max_y; bottom row, decrement $max_x; left column, increment $min_y.
#
# We're done when $min_x > $max_x, or $min_y > $max_y.
#

my @matrix = map {[/[1-9][0-9]*/g]} <>;

#
# Check whether all lines are the same size
#
die "Not a matrix" if grep {@$_ != @{$matrix [0]}} @matrix;

my $EAST      = 0;
my $SOUTH     = 1;
my $WEST      = 2;
my $NORTH     = 3;

my $direction = $EAST;

my $min_x     = 0,
my $max_x     = $#matrix;
my $min_y     = 0;
my $max_y     = $#{$matrix [0]};


my @out;
while ($min_x <= $max_x && $min_y <= $max_y) {
       if ($direction == $EAST) {
        push @out =>         map {$matrix [$min_x] [$_]}     $min_y .. $max_y;
        $min_x ++;
    }
    elsif ($direction == $SOUTH) {
        push @out =>         map {$matrix [$_]     [$max_y]} $min_x .. $max_x;
        $max_y --;
    }
    elsif ($direction == $WEST) {
        push @out => reverse map {$matrix [$max_x] [$_]}     $min_y .. $max_y;
        $max_x --;
    }
    elsif ($direction == $NORTH) {
        push @out => reverse map {$matrix [$_]     [$min_y]} $min_x .. $max_x;
        $min_y ++;
    }

    $direction = ($direction + 1) % ($NORTH + 1);
}

$, = ", ";
say @out;

__END__
