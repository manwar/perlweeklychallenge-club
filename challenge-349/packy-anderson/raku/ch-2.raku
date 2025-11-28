#!/usr/bin/env raku
use v6;

sub meetingPoint($path) {
  my ($x, $y) = (0, 0);
  for $path.comb() -> $step {
    given $step {
      when "U" { $y++ }
      when "D" { $y-- }
      when "R" { $x++ }
      when "L" { $x-- }
    }
    return True when $x == 0 && $y == 0;
  }
  return False;
}

sub solution($path) {
  say qq/Input: \$path = "$path"/;
  say 'Output: ' ~ meetingPoint($path);
}

say "Example 1:";
solution("ULD");

say "\nExample 2:";
solution("ULDR");

say "\nExample 3:";
solution("UUURRRDDD");

say "\nExample 4:";
solution("UURRRDDLLL");

say "\nExample 5:";
solution("RRUULLDDRRUU");
