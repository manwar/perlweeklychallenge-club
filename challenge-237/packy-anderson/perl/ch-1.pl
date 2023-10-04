#!/usr/bin/env perl
use v5.38;

# let's use the core modules for date manipulation
use Time::Piece;
use Time::Seconds qw( ONE_DAY );
use Lingua::EN::Inflexion qw( noun );

sub seizeTheDay {
  my %params = @_;
  # build the first day of the specified month
  my $start = $params{year} . '-' . $params{month} . '-01';
  # create an object for that day
  my $t = Time::Piece->strptime($start, "%Y-%m-%d")
                     ->truncate(to => 'day');
  # in Time::Piece->wday, 1 = Sun, 2 = Mon, 3 = Tue, but our
  # input is 0 = Sun, 1 = Mon, 2 = Tue, so adjust our input
  $params{day_of_week}++;

  # find the FIRST instance of the desired day of the week
  while ( $t->wday != $params{day_of_week} ) {
    $t += ONE_DAY; # add 1 day
  }

  # take note of some values that won't change
  # for our description
  my $year  = $t->year;
  my $month = $t->month;
  my $dow   = $t->wdayname;
  my $count = 1;

  my $ord_weekday_of_month = 
    noun($params{weekday_of_month})->ordinal(0);

  # now roll forward through the month until the desired
  # weekday of the month
  while (
    # we're still in the desired month
    $t->mon == $params{month}
    &&
    # we haven't reached the desired weekday of the month
    $count < $params{weekday_of_month}
  ) {
    # add a week to the date
    $t += ONE_DAY * 7;
    # add to the weekday of the month count
    $count++;
  }

  # if we rolled out of the month, return an error condition
  if ($t->mon != $params{month}) {
    return 0, "There isn't a $ord_weekday_of_month $dow "
            . "in $month $year";
  }
  else {
    # take note of what the day of the month is
    my $day = $t->day_of_month;
    my $ord_day_of_month = noun($day)->ordinal(0);
    return $day, "The $ord_weekday_of_month $dow "
               . "of $month $year is the $ord_day_of_month";
  }
}

sub solution {
  my %params = @_;
  say 'Input: Year = '             . $params{year}
    .      ', Month = '            . $params{month}
    .      ', Weekday of month = ' . $params{weekday_of_month}
    .      ', day of week = '      . $params{day_of_week};
  my ($day, $desc) = seizeTheDay(%params);
  say 'Output: ' . $day;
  say "\n$desc";
}

say "Example 1:";
solution(
  year             => 2024, 
  month            => 4, 
  weekday_of_month => 3, 
  day_of_week      => 2
);

say "\nExample 2:";
solution(
  year             => 2025, 
  month            => 10, 
  weekday_of_month => 2, 
  day_of_week      => 4
);

say "\nExample 3:";
solution(
  year             => 2026, 
  month            => 8,
  weekday_of_month => 5, 
  day_of_week      => 3
);
