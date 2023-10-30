#!/usr/bin/env raku
use v6;

use Date::Names;
use Lingua::EN::Numbers; # for ordinal-digit()

sub seizeTheDay(
  Int :$year,
  Int :$month,
  Int :$weekday_of_month,
  Int :$day_of_week
) {
  # object for the first day of the specified month
  my $t = Date.new($year, $month, 1);

  # in Date.day-of-week, 0 = Sun, 1 = Mon, 2 = Tue,
  # which matches our input, so no adjustment is needed

  # find the FIRST instance of the desired day of the week
  while ( $t.day-of-week != $day_of_week ) {
    $t++; # add 1 day
  }

  # instantiate a Date::Names object
  my $dn = Date::Names.new;

  # take note of some values that won't change
  # for our description
  my $month_name = $dn.mon($t.month);
  my $dow        = $dn.dow($t.day-of-week);
  my $count      = 1;

  my $ord_weekday_of_month = ordinal-digit($weekday_of_month);

  # now roll forward through the month until the desired
  # weekday of the month
  while (
    # we're still in the desired month
    $t.month == $month
    &&
    # we haven't reached the desired weekday of the month
    $count < $weekday_of_month
  ) {
    # add a week to the date
    $t += 7;
    # add to the weekday of the month count
    $count++;
  }

  # if we rolled out of the month, return an error condition
  if ($t.month != $month) {
    return 0, "There isn't a $ord_weekday_of_month $dow "
            ~ "in $month $year";
  }
  else {
    # take note of what the day of the month is
    my $day = $t.day;
    my $ord_day_of_month = ordinal-digit($day);
    return $day, "The $ord_weekday_of_month $dow "
               ~ "of $month $year is the $ord_day_of_month";
  }
}

sub solution(
  Int :$year,
  Int :$month,
  Int :$weekday_of_month,
  Int :$day_of_week
) {
  say 'Input: Year = '             ~ $year
    ~      ', Month = '            ~ $month
    ~      ', Weekday of month = ' ~ $weekday_of_month
    ~      ', day of week = '      ~ $day_of_week;
  my ($day, $desc) = seizeTheDay(
    year             => $year, 
    month            => $month, 
    weekday_of_month => $weekday_of_month, 
    day_of_week      => $day_of_week
  );
  say 'Output: ' ~ $day;
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
