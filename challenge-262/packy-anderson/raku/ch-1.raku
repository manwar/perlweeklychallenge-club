#!/usr/bin/env raku
use v6;

sub maxPosNeg(@ints) {
  my $pos = [+] @ints.map({ $_ > 0 ?? 1 !! 0 });
  my $neg = [+] @ints.map({ $_ < 0 ?? 1 !! 0 });
  my $max = max $pos, $neg;
  return (
    $max,
    (
      "Count of positive integers: $pos",
      "Count of negative integers: $neg",
      "Maximum of count of positive and " ~
      "negative integers: $max"
    ).join("\n")
  );
}

sub solution(@ints) {
  say 'Input: @arr = (' ~ @ints.join(', ') ~ ')';
  my ($max, $explain) = maxPosNeg(@ints);
  say "Output: $max\n\n$explain";
}

say "Example 1:";
solution([-3, 1, 2, -1, 3, -2, 4]);

say "\nExample 2:";
solution([-1, -2, -3, 1]);

say "\nExample 3:";
solution([1,2]);