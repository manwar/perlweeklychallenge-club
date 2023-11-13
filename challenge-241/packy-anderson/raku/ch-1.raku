#!/usr/bin/env raku
use v6;

sub findTriplets($diff, @nums) {
  my $count = 0;
  my $details = q{};
  for 0 .. @nums.elems - 3 -> $i {
    for $i + 1 .. @nums.elems - 2 -> $j {
      next unless @nums[$j] - @nums[$i] == $diff;
      for $j + 1 .. @nums.elems - 1 -> $k {
        next unless @nums[$k] - @nums[$j] == $diff;
        $count++;
        $details ~= "($i, $j, $k) is an arithmetic triplet "
          ~  "because both @nums[$k] - @nums[$j] = $diff "
          ~  "and @nums[$j] - @nums[$i] = $diff\n";
      }
    }
  }
  return ($count, $details);
}

sub solution($diff, @nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  say '       $diff = ' ~ $diff;
  my ($count, $details) = findTriplets($diff, @nums);
  say "Output: $count\n\n$details";
}

say "Example 1:";
solution(3, [0, 1, 4, 6, 7, 10]);

say "\nExample 2:";
solution(2, [4, 5, 6, 7, 8, 9]);