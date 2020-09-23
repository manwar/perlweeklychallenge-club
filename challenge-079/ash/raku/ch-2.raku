#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/

my @shape = 2, 1, 4, 1, 2, 5;

# Make the matrix and fill it with '#' (bricks) and '~' (water);
my $height = max(@shape);
my @map;
for @shape -> $cell {
    push @map, Array.new(('#' xx $cell, '~' xx ($height - $cell)).flat);
}

blow-water-out(0, @shape.end);
blow-water-out(@shape.end, 0);

.join.say for @map;

# Units of water left
say @map.join.join.indices('~').elems;

sub blow-water-out($from, $to) {
    # Blow from left or from right to remove high waters.
    my $max = @shape[$from]; # Height of the left-most (or right-most) cell
    for $from ... $to -> $pos {
        $max = @shape[$pos] if @shape[$pos] > $max; # Raising wall, increase the maximum

        # Remove water above the current maximum and fill it with air
        @map[$pos; $_] = '.' for $max ..^ $height;
    }
}
