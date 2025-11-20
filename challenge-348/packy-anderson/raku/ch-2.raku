#!/usr/bin/env raku
use v6;

sub convertTime($source, $target) {
  # find difference between $source and $target
  my $s = DateTime.new("2000-01-01T$source:00");
  my $t = DateTime.new("2000-01-01T$target:00");
  if ($t < $s) { # it must be a time in the next day
    $t = $t.later(days => 1);
  }
  my $diff = ($t - $s) / 60; # (t-s) is in seconds
  # find how many operations needed
  my @ops;
  for [60, 15, 5, 1] -> $op {
    if (my $n = $diff div $op) {
      my $min = $op == 1 ?? "minute" !! "minutes";
      @ops.push("Add $op $min") for 1..$n;
      $diff -= $n * $op;
      last unless $diff > 0;
    }
  }
  my $count = @ops.elems;
  my $operations = $count == 1 ?? "Operation" !! "Operations";
  return "$count\n\n$operations:\n + {@ops.join(qq/\n + /)}";
}

sub solution($source, $target) {
  say qq/Input: \$source = "$source"/;
  say qq/       \$target = "$target"/;
  say 'Output: ' ~ convertTime($source, $target);
}

say "Example 1:";
solution("02:30", "02:45");

say "\nExample 2:";
solution("11:55", "12:15");

say "\nExample 3:";
solution("09:00", "13:00");

say "\nExample 4:";
solution("23:45", "00:30");

say "\nExample 5:";
solution("14:20", "15:25");
