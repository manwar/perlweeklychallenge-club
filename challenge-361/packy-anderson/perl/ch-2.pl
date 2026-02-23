#!/usr/bin/env perl
use v5.40;

sub celebrity(@party) {
  my (@knows, @known_by);
  my $n = $#party;
  for my $i (0 .. $n) {
    for my $j (0 .. $n) {
      $knows[$i]    += $party[$i][$j];
      $known_by[$j] += $party[$i][$j];
    }
  }
  for my $i (0 .. $n) {
    next unless $knows[$i] == 0; # knows nobody
    next unless $known_by[$i] == $n; # eveyone knows
    return $i;
  }
  return -1;
}

sub formatMatrix($matrix, $indent=16) {
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

sub solution($party) {
  say 'Input: @party = ' . formatMatrix($party);
  say 'Output: ' . celebrity(@$party);
}

say "Example 1:";
solution([
  [0, 0, 0, 0, 1, 0],  # 0 knows 4
  [0, 0, 0, 0, 1, 0],  # 1 knows 4
  [0, 0, 0, 0, 1, 0],  # 2 knows 4
  [0, 0, 0, 0, 1, 0],  # 3 knows 4
  [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
  [0, 0, 0, 0, 1, 0],  # 5 knows 4
]);

say "\nExample 2:";
solution([
  [0, 1, 0, 0],  # 0 knows 1
  [0, 0, 1, 0],  # 1 knows 2
  [0, 0, 0, 1],  # 2 knows 3
  [1, 0, 0, 0]   # 3 knows 0
]);

say "\nExample 3:";
solution([
  [0, 0, 0, 0, 0],  # 0 knows NOBODY
  [1, 0, 0, 0, 0],  # 1 knows 0
  [1, 0, 0, 0, 0],  # 2 knows 0
  [1, 0, 0, 0, 0],  # 3 knows 0
  [1, 0, 0, 0, 0]   # 4 knows 0
]);

say "\nExample 4:";
solution([
  [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
  [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
  [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
  [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
  [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
  [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
]);

say "\nExample 5:";
solution([
  [0, 1, 1, 0],  # 0 knows 1 and 2
  [1, 0, 1, 0],  # 1 knows 0 and 2
  [0, 0, 0, 0],  # 2 knows NOBODY
  [0, 0, 0, 0]   # 3 knows NOBODY
]);

say "\nExample 6:";
solution([
  [0, 0, 1, 1],  # 0 knows 2 and 3
  [1, 0, 0, 0],  # 1 knows 0
  [1, 1, 0, 1],  # 2 knows 0, 1 and 3
  [1, 1, 0, 0]   # 3 knows 0 and 1
]);

