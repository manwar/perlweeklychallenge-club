#!/usr/bin/env raku
use v6;

sub diffArrayAsString($word) {
  my @arr = $word.comb.map: *.ord - 97;
  my @diff;
  for 0 .. @arr.end - 1 -> $j {
    @diff[$j] = @arr[$j + 1] - @arr[$j];
  }
  @diff.join(" ")
}

sub stringDifference(@words) {
  my %diffs;
  for @words -> $word {
    %diffs{diffArrayAsString($word)}.push($word);
  }
  %diffs.values.grep({ $_.elems == 1 })[0];
}

sub solution(@words) {
  say 'Input: @words = (' ~ @words.map({ qq/"$_"/ }).join(', ') ~ ')';
  say 'Output: "' ~ stringDifference(@words) ~ '"';
}

say "Example 1";
solution(["ab", "bc", "cd", "zy"]);

say "\nExample 2";
solution(["cba", "fed", "azy"]);

say "\nExample 3";
solution(["pop", "ada", "beb", "cfc"]);

say "\nExample 4";
solution(["aaaa", "zzzz", "mmmm", "aaba"]);

say "\nExample 5";
solution(["aceg", "bdfh", "cegi", "azbz"]);
