#!/usr/bin/env perl
use v5.40;

sub starts_with($str, $substr) { index($str, $substr) == 0; }

sub ends_with($str, $substr) {
  rindex($str, $substr) == length($str) - length($substr);
}

sub prefixSuffix(@array) {
  my ($count, $explain) = (0, "");
  for my $i ( 0 .. $#array - 1 ) {
    my $istr = $array[$i];
    for my $j ( $i+1 .. $#array ) {
      my $jstr = $array[$j];
      next unless starts_with($jstr, $istr)
               && ends_with($jstr, $istr);
      $count++;
      $explain .= qq{\n\$array[$i], \$array[$j]: "$istr" is }
                . qq{a prefix and suffix of "$jstr"};
    }
  }
  return $count, $explain;
}

sub solution($array) {
  say 'Input: @array = (' . join(', ', map {qq/"$_"/} @$array) . ')';
  my ($count, $explain) = prefixSuffix(@$array);
  say 'Output: ' . $count;
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
