#!/usr/bin/env perl
use v5.40;

use Time::Piece;

sub solution($date) {
  say qq{Input: \$date = '$date'};
  my $tp = Time::Piece->strptime($date, "%Y-%m-%d")
                      ->truncate(to => 'day');
  my $day_of_year = $tp->day_of_year + 1;
  say qq{Output: $day_of_year};
}

say "Example 1:";
solution('2025-02-02');

say "\nExample 2:";
solution('2025-04-10');

say "\nExample 3:";
solution('2025-09-07');
