#!/usr/bin/env raku
use v6;

class ReversePairArray is Array {
  method isReversePair($i, $j) {
    return self[$i] > 2 * self[$j];
  }
}

sub findReversePairs(@arr) {
  my @pairs;
  my @rpArray := ReversePairArray.new(@arr);
  for 0 .. @rpArray.elems - 2 -> $i {
    for $i+1 .. @rpArray.elems - 1 -> $j {
      @pairs.push([$i, $j]) if @rpArray.isReversePair($i, $j);
    }
  }
  return @pairs;
}

sub solution(*@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  my @pairs = findReversePairs(@nums);
  say 'Output: ' ~ @pairs.elems ~ "\n";
  for @pairs -> @pair {
    my ($i, $j) = @pair;
    print "($i, $j) => ";
    print "nums[$i] = @nums[$i], nums[$j] = @nums[$j], ";
    say   "@nums[$i] > 2 * @nums[$j]";
  }
}

say "Example 1:";
solution(1, 3, 2, 3, 1);

say "\nExample 2:";
solution(2, 4, 3, 5, 1);
