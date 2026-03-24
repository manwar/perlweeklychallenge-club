#!/usr/bin/env raku
use v6;

sub possible($field, $max) {
  return $max+1 if $field eq "??";
  return $field <= $max ?? 1 !! 0 unless $field.contains("?");
  my $count = 0;
  for 0..9 -> $i {
    return $count if $field.subst("?", $i) > $max;
    $count++;
  }
  return $count;
}

sub validTimes($time) {
  my ($hours, $minutes) = $time.split(":");
  return possible($hours, 23) * possible($minutes, 59);
}

sub solution($time) {
  say qq/Input: \$time = "$time"/;
  say 'Output: ' ~ validTimes($time);
}

say "Example 1:";
solution("?2:34");

say "\nExample 2:";
solution("?4:?0");

say "\nExample 3:";
solution("??:??");

say "\nExample 4:";
solution("?3:45");

say "\nExample 5:";
solution("2?:15");

say "\nExample Trivial 1:";
solution("23:59");

say "\nExample Trivial 2:";
solution("25:1?");
