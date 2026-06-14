#!/usr/bin/env raku
use v6;

sub prefixSuffix(@array) {
  my ($count, $explain) = (0, "");
  for 0 .. @array.end - 1 -> $i {
    my $istr = @array[$i];
    for $i+1 .. @array.end -> $j {
      my $jstr = @array[$j];
      next unless $jstr.starts-with($istr)
               && $jstr.ends-with($istr);
      $count++;
      $explain ~= qq{\n\$array[$i], \$array[$j]: "$istr" is }
                ~ qq{a prefix and suffix of "$jstr"};
    }
  }
  return $count, $explain;
}

sub solution(@array) {
  say 'Input: @array = (' ~ @array.map({qq/"$_"/}).join(', ') ~ ')';
  my ($count, $explain) = prefixSuffix(@array);
  say 'Output: ' ~ $count;
  say $explain if $count;
}

say "Example 1:";
solution(["a", "aba", "ababa", "aa"]);

say "\nExample 2:";
solution(["pa", "papa", "ma", "mama"]);

say "\nExample 3:";
solution(["abao", "ab"]);

say "\nExample 4:";
solution(["abab", "abab"]);

say "\nExample 5:";
solution(["ab", "abab", "ababab"]);

say "\nExample 6:";
solution(["abc", "def", "ghij"]);