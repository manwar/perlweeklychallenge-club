#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub stronger($i, $j, @grid) {
  return $i if $grid[$i][$j] == 1;
  return $j if $grid[$i][$j] == 0;
}

sub championTeam(@grid) {
  my @best;
  my $max = 0;
  foreach my $team ( 0 ..  $#grid ) {
    my $sum = sum(@{$grid[$team]});
    if ($sum > $max) {
      @best = ($team);
      $max = $sum;
    }
    elsif ($sum == $max) {
      push @best, $team;
    }
  }
  if (@best == 1) {
    return $best[0];
  }
  my ($i, $j) = @best;
  return stronger($i, $j, @grid);
}

sub formatMatrix($matrix, $indent=15) {
  my @output;
  foreach my $row (@$matrix) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', map { sprintf "%1d", $_ } @$row) . ']';
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}

sub solution($grid) {
  say 'Input: @grid = ' . formatMatrix($grid);
  say 'Output: Team ' . championTeam(@$grid);
}

say "Example 1:";
solution([
  [0, 1, 1],
  [0, 0, 1],
  [0, 0, 0]
]);

say "\nExample 2:";
solution([
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [1, 1, 0, 0],
  [1, 1, 1, 0]
]);

say "\nExample 3:";
solution([
  [0, 1, 0, 1],
  [0, 0, 1, 1],
  [1, 0, 0, 0],
  [0, 0, 1, 0]
]);

say "\nExample 4:";
solution([
  [0, 1, 1],
  [0, 0, 0],
  [0, 1, 0]
]);

say "\nExample 5:";
solution([
  [0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0],
  [1, 1, 0, 1, 1],
  [1, 1, 0, 0, 0],
  [1, 1, 0, 1, 0]
]);

