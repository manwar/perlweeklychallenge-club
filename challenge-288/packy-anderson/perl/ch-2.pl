#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

# helper functions to determine if the adjacent cells
# BEFORE this one have the same value
sub prevXSame($matrix, $x, $y) {
  return $x > 0 && $$matrix[$y]->[$x] eq $$matrix[$y]->[$x-1];
}
sub prevYSame($matrix, $x, $y) {
  return $y > 0 && $$matrix[$y]->[$x] eq $$matrix[$y-1]->[$x];
}

sub contiguousBlock($matrix) {
  # first, find out the size of the matrix
  my $height = $#{$matrix};
  my $width  = $#{$$matrix[0]};
  # start a counter for the number of blocks
  my $next_block = 0;
  # a matrix of blocks
  my @blocks;

  foreach my $y (0 .. $height) {
    foreach my $x (0 .. $width) {
      if (prevXSame($matrix, $x, $y)) {
        # make this cell's block number match
        # the one above it
        $blocks[$y][$x] = $blocks[$y][$x-1];
      }
      if (prevYSame($matrix, $x, $y)) {
        # if we've already assigned a block number
        # based on the prev X being the same, and
        # it's a DIFFERENT block than the prev Y
        if (defined($blocks[$y][$x]) && 
            $blocks[$y][$x] != $blocks[$y-1][$x]) {
          # renumber the block for the prev X to
          # match the block for the prev Y
          my $new = $blocks[$y-1][$x];
          my $old = $blocks[$y][$x-1];
          foreach my $y2 (0 .. $y) {
            foreach my $x2 (0 .. $width)  {
              $blocks[$y2][$x2] = $new
                if $blocks[$y2][$x2] == $old;
            }
          }
        }
        # make this cell's block number match
        # the one before it
        $blocks[$y][$x] = $blocks[$y-1][$x];
      }
      if (! defined $blocks[$y][$x]) {
        # neither previous adjacent cell matches,
        # assign a new block number to this cell
        $blocks[$y][$x] = $next_block++;
      }
    }
  }

  # now let's count the elements in each block
  my @counts;
  foreach my $y (0 .. $height) {
    foreach my $x (0 .. $width) {
      $counts[$blocks[$y][$x]]++;
    }
  }

  return max(@counts);
}

sub solution($matrix) {
  say 'Input: $matrix = ' . formatMatrix($matrix);
  say 'Output: ' . contiguousBlock($matrix);
}

sub formatMatrix($matrix, $indent=17) {
  my @output;
  foreach my $row (@$matrix) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', map { sprintf "'%1s'", $_ } @$row) . ']';
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}

say "Example 1:";
solution([
           ['x', 'x', 'x', 'x', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'x', 'x', 'o', 'o'],
         ]);

say "\nExample 2:";
solution([
           ['x', 'x', 'x', 'x', 'x'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'x', 'x', 'x', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
         ]);

say "\nExample 3:";
solution([
           ['x', 'x', 'x', 'o', 'o'],
           ['o', 'o', 'o', 'x', 'x'],
           ['o', 'x', 'x', 'o', 'o'],
           ['o', 'o', 'o', 'x', 'x'],
         ]);
