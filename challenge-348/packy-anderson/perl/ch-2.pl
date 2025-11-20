#!/usr/bin/env perl
use v5.40;
use Time::Piece;
use Time::Seconds qw( ONE_DAY );

sub mytime($str) {
  Time::Piece->strptime("2000-01-01T$str", "%Y-%m-%dT%H:%M");
}

sub convertTime($source, $target) {
  # find difference between $source and $target
  my $s = mytime($source);
  my $t = mytime($target);
  if ($t < $s) { # it must be a time in the next day
    $t += ONE_DAY;
  }
  my $diff = ($t - $s) / 60; # (t-s) is in seconds
  # find how many operations needed
  my @ops;
  foreach my $op (60, 15, 5, 1) {
    if (my $n = int($diff / $op)) {
      my $min = $op == 1 ? "minute" : "minutes";
      push @ops, "Add $op $min" for 1..$n;
      $diff -= $n * $op;
      last unless $diff > 0;
    }
  }
  my $count = scalar(@ops);
  my $operations = $count == 1 ? "Operation" : "Operations";
  return "$count\n\n$operations:\n + @{[join(qq/\n + /, @ops)]}";
}

sub solution($source, $target) {
  say qq/Input: \$source = "$source"/;
  say qq/       \$target = "$target"/;
  say 'Output: ' . convertTime($source, $target);
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
