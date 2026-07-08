#!/usr/bin/env raku
use v6;

sub hasAllNum($n, @elems) {
  my $set = set @elems;
  return False unless $set.elems == $n; # check num of elems
  for 1 .. $n -> $i {
    return False unless $i ∈ $set;
  }
  return True;
}

sub sameRowColumn(@matrix) {
  my $n = @matrix.elems;
  for @matrix -> @row {
    # check the row
    return False unless hasAllNum($n, @row);
  }
  # check columns
  for [Z] @matrix -> @col {
    return False unless hasAllNum($n, @col);
  }
  return True;
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
  say 'Input: @matrix = ' ~ formatMatrix(@matrix);
  say 'Output: ' ~ sameRowColumn(@matrix);
}

say "Example 1:";
solution([
  [1, 2, 3, 4],
  [2, 3, 4, 1],
  [3, 4, 1, 2],
  [4, 1, 2, 3]
]);

say "\nExample 2:";
solution([[1],]);

say "\nExample 3:";
solution([
  [1, 2, 5],
  [5, 1, 2],
  [2, 5, 1]
]);

say "\nExample 4:";
solution([
  [1, 2, 3],
  [1, 2, 3],
  [1, 2, 3] 
]);

say "\nExample 5:";
solution([
  [1, 2, 3],
  [3, 1, 2],
  [3, 2, 1]
]);
