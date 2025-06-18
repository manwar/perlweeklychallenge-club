#!/usr/bin/env raku
use v6;

sub solution($date) {
  say qq{Input: \$date = '$date'};
  my $day_of_year = Date.new($date).day-of-year;
  say qq{Output: $day_of_year};
}

say "Example 1:";
solution('2025-02-02');

say "\nExample 2:";
solution('2025-04-10');

say "\nExample 3:";
solution('2025-09-07');
