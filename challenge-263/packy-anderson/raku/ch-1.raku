#!/usr/bin/env raku
use v6;

sub targetIndex($k, @ints) {
  my @sorted = @ints.sort;
  my $explain = 'Sorted array: (' ~ @sorted.join(', ') ~ ")\n";

  my @output;
  for @sorted.kv -> $i, $v {
    next unless $v == $k;
    @output.push($i);
  }
  if (@output == 0) {
    $explain ~= 'No element in the given array matching '
             ~  'the given target.';
  }
  else {
    $explain ~= 'Target indices: (' ~ @output.join(', ')
             ~  ') as ';
    my @explain_indices = @output.map({ "\$ints[$_] = $k"});
    $explain ~= @explain_indices.join(' and ');
  }
  return $explain, @output;
}

sub solution($k, @ints) {
  my $intlist = @ints.join(', ');
  say "Input: \@ints = ($intlist), \$k = $k";
  my ($explain, @output) = targetIndex($k, @ints);
  $intlist = @output.join(', ');
  say "Output: ($intlist)\n\n$explain";
}

say "Example 1:";
solution(2, [1, 5, 3, 2, 4, 2]);

say "\nExample 2:";
solution(6, [1, 2, 4, 3, 5]);

say "\nExample 3:";
solution(4, [5, 3, 2, 4, 2, 1]);