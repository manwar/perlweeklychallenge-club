#!/usr/bin/env raku
use v6;

sub ascendingNum($str) {
  my @list = $str.comb(/\d+/);
  while (@list.elems > 1) {
    return False if @list[0] >= @list[1];
    @list.shift;
  }
  return True;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say "Output: {ascendingNum($str)}";
}

say "Example 1:";
solution("The cat has 3 kittens 7 toys 10 beds");

say "\nExample 2:";
solution("Alice bought 5 apples 2 oranges 9 bananas");

say "\nExample 3:";
solution("I ran 1 mile 2 days 3 weeks 4 months");

say "\nExample 4:";
solution("Bob has 10 cars 10 bikes");

say "\nExample 5:";
solution("Zero is 0 one is 1 two is 2");
