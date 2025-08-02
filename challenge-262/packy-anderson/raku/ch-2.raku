#!/usr/bin/env raku
use v6;

sub countEquDiv($k, @ints) {
  my @explain;
  my $cnt = 0;
  for 0 .. @ints.end - 1 -> $i {
    for $i + 1 .. @ints.end -> $j {
      # does ints[i] == ints[j]?
      next unless @ints[$i] == @ints[$j];
      # is i x j divisible by k?
      next unless ( ($i * $j) mod $k ) == 0;
      # count the pair and explain why
      $cnt++;
      @explain.push(
        "($i, $j) => ints[$i] == ints[$j] " ~
        "and $i x $j is divisible by $k"
      );
    }
  }
  return($cnt, @explain.join("\n"));
}

sub solution($k, @ints) {
  say 'Input: @arr = (' ~ @ints.join(', ')
    ~ ') and $k = ' ~ $k;
  my ($cnt, $explain) = countEquDiv($k, @ints);
  say "Output: $cnt\n\n$explain";
}

say "Example 1:";
solution(2, [3,1,2,2,2,1,3]);

say "\nExample 2:";
solution(1, [1,2,3]);
