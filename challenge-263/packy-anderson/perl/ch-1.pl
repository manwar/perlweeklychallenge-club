#!/usr/bin/env perl
use v5.38;

sub targetIndex($k, @ints) {
  my @sorted = sort @ints;
  my $explain = 'Sorted array: (' . join(', ', @sorted) . ")\n";

  my @output;
  foreach my $i (0 .. $#sorted) {
    next unless $sorted[$i] == $k;
    push @output, $i;
  }
  if (@output == 0) {
    $explain .= 'No element in the given array matching '
             .  'the given target.';
  }
  else {
    $explain .= 'Target indices: (' . join(', ', @output)
             .  ') as ';
    my @explain_indices = map { "\$ints[$_] = $k"} @output;
    $explain .= join(' and ', @explain_indices);
  }
  return $explain, @output;
}

sub solution($k, $ints) {
  my $intlist = join(', ', @$ints);
  say "Input: \@ints = ($intlist), \$k = $k";
  my ($explain, @output) = targetIndex($k, @$ints);
  $intlist = join(', ', @output);
  say "Output: ($intlist)\n\n$explain";
}

say "Example 1:";
solution(2, [1, 5, 3, 2, 4, 2]);

say "\nExample 2:";
solution(6, [1, 2, 4, 3, 5]);

say "\nExample 3:";
solution(4, [5, 3, 2, 4, 2, 1]);