#!/usr/bin/env perl
use v5.44;

sub diffArrayAsString($word) {
  my @arr = map { ord($_) - 97 } split //, $word;
  my @diff;
  for my $j ( 0 .. $#arr - 1 ) {
    $diff[$j] = $arr[$j + 1] - $arr[$j];
  }
  join(" ", @diff)
}

sub stringDifference(@words) {
  my %diffs;
  for my $word ( @words ) {
    push @{ $diffs{diffArrayAsString($word)} }, $word;
  }
  # grep will return a single element list of array refs
  ( grep { scalar(@$_) == 1 } values %diffs )[0]->[0];
}

sub solution($words) {
  say 'Input: @words = (' . join(', ', map { qq/"$_"/ } @$words) . ')';
  say 'Output: "' . stringDifference(@$words) . '"';
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
