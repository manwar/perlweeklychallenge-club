#!/usr/bin/env raku
use v6;

use Lingua::Conjunction;

sub maxFrequency(@ints) {
  my $freq = bag @ints;
  my $maxFreq = max($freq.values);
  my @atMax;
  for $freq.keys.sort -> $i {
    if ($freq{$i} == $maxFreq) {
      @atMax.push($i);
    }
  }
  my $explain = "The maximum frequency is $maxFreq.\n"
              ~ "The element[|s] |list| [has|have] "
              ~ "the maximum frequency.";
  return(
    $maxFreq * @atMax.elems,
    conjunction(@atMax, :str($explain))
  );
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($count, $explain) = maxFrequency(@ints);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([1, 2, 2, 4, 1, 5]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);
