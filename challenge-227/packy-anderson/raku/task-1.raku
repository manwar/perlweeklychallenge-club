#!/usr/bin/env raku

sub MAIN($year) {
  # do bounds checking as specified in the problem
  if ($year < 1753 || $year > 9999) {
    say "Only years between 1753 to 9999 are allowed ($year is out of range)";
    exit 1;
  }

  # create an object for Jan 01 of the given year
  my $t = Date.new($year, 1, 1);

  # find the first friday
  # in Date.day-of-week, 0 = Sunday, 5 = Friday
  while ( $t.day-of-week != 5) {
    $t++; # add 1 day
  }

  # now keep adding 7 days to the date until the year changes,
  # noting how many times the day of the month is 13
  my $thirteen_count = 0;
  while ( $t.year == $year ) {
    $thirteen_count++ if $t.day == 13;
    $t += 7;
  }

  say "Input: \$year = $year";
  say "Output: $thirteen_count";
}