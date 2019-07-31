#!/usr/bin/env perl6

my $format-it = sub ($self) {
  sprintf "%04d month %02d", .year, .month given $self;
}

sub MAIN(Int :$from-year = 1900, Int :$to-year where * > $from-year = 2019, Int :$weekend-length where * ~~ 1..3 = 3) {
  my $date-loop = Date.new($from-year, 1, 1, formatter => $format-it);
  while ($date-loop.year <= $to-year) {
    my $date = $date-loop.later(day => $date-loop.days-in-month);
    $date = $date.truncated-to('week').pred if $date.day-of-week != 7;
    my @weekend = do for 0..^$weekend-length -> $w {
      $date.earlier(day => $w).weekday-of-month;
    };
    say $date-loop if ([+] @weekend) / @weekend == 5;
    $date-loop = $date-loop.later(:1month);
  }
}
