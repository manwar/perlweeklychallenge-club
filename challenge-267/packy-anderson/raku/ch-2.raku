#!/usr/bin/env raku
use v6;

sub lineCounts($str, @widths) {
  my ($lines, $last_line, $last_width, $explain) =
    (0, '', 0, '');
  my %width = ('a' .. 'z' Z @widths).flat.Hash;
  for $str.comb -> $c {
      if ($last_width + %width{$c} > 100) {
        $lines++;
        $explain ~= "\nLine $lines: $last_line "
                 ~  "($last_width pixels)";
        ($last_line, $last_width) = ($c, %width{$c});
      }
      else {
        $last_line  ~= $c;
        $last_width += %width{$c};
      }
  }
  $lines++;
  $explain ~= "\nLine $lines: $last_line "
           ~  "($last_width pixels)";
  return ($lines, $last_width, $explain);
}

sub solution($str, @widths) {
  say qq{Input: \$str = "$str"};
  say qq{       \@widths = (} ~ @widths.join(', ') ~ ')';
  my ($lines, $last_width, $explain) =
    lineCounts($str, @widths);
  say qq{Output: ($lines, $last_width)$explain};
}

say "Example 1:";
solution(
  "abcdefghijklmnopqrstuvwxyz",
  [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
);

say "\nExample 2:";
solution(
  "bbbcccdddaaa",
  [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
);

say "\nExample 3:";
solution(
  "thequickbrownfoxjumpedoverthelazydog",
  [7,8,7,8,7,5,8,8,4,4,8,4,12,8,8,8,8,5,6,4,8,8,12,8,8,7]
);