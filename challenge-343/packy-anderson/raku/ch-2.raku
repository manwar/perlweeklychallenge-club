#!/usr/bin/env raku
use v6;

sub stronger($i, $j, @grid) {
  return $i if @grid[$i][$j] == 1;
  return $j if @grid[$i][$j] == 0;
}

sub championTeam(@grid) {
  my @best;
  my $max = 0;
  for @grid.keys -> $team {
    my $sum = @grid[$team].sum;
    if ($sum > $max) {
      @best = ($team);
      $max = $sum;
    }
    elsif ($sum == $max) {
      @best.push($team);
    }
  }
  if (@best.elems == 1) {
    return @best[0];
  }
  my ($i, $j) = @best;
  return stronger($i, $j, @grid);
}

sub formatMatrix(@matrix, $indent=15) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [";
    $output_row ~= @row.map({ sprintf "%1d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}

sub solution(@grid) {
  say 'Input: @grid = ' ~ formatMatrix(@grid);
  say 'Output: Team ' ~ championTeam(@grid);
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
