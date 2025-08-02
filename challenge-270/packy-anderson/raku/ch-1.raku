#!/usr/bin/env raku
use v6;

use Lingua::Conjunction;

sub sumRow(@matrix, $i) {
  return [+] @matrix[$i].values;
}

sub sumCol(@matrix, $j) {
  return [+] ( @matrix.map: { .[$j] } );
}

sub specialPositions(@matrix) {
  my @special;
  for @matrix.kv -> $i, @row {
    for @row.kv -> $j, $value {
      # not special unless = 1
      next unless $value == 1;
      # not special unless only 1 in row
      next unless sumRow(@matrix, $i) == 1;
      # not special unless only 1 in column
      next unless sumCol(@matrix, $j) == 1;
      # it's special!
      @special.push( "($i, $j)" );
    }
  }
  my $str = 'Special position[|s] [is|are] |list|';
  return @special.elems, conjunction(@special, :$str, :alt<,>);
}

sub formatMatrix(@matrix, $indent=17) {
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

sub solution(@matrix) {
  say 'Input: $matrix = ' ~ formatMatrix(@matrix);
  my ($count, $explain) = specialPositions(@matrix);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([
  [1,0,0],
  [0,0,1],
  [1,0,0]
]);

say "\nExample 2:";
solution([
  [1,0,0],
  [0,1,0],
  [0,0,1]
]);
