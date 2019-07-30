#! /usr/bin/env perl6

my @months;

for 1900 .. 2019 -> $year
{
  for 1 .. 12 -> $month
  {
    my $date = Date.new($year, $month, 1);
    @months.push( $date.year ~ "-" ~ $date.month.fmt('%02s') )
      if $date.day-of-week == 5 && $date.days-in-month == 31;
  }
}

say "Months with five weekends: { @months.join(", ") }.";
