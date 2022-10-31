sub last-sunday(Int $year)
{
  for 1..12 -> $month
  {
    my $end = Date.new($year,
		       $month,
		       Date.new($year, $month, 1).days-in-month);
    say $end - $end.day-of-week % 7;
  }
}

sub MAIN(Int $year)
{
  last-sunday($year);
}
