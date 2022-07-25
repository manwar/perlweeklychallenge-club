use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-25
# Challenge 175 Last Sunday ( Raku )

sub CreateDateTime ( $y, $m ) {                # create a Date object for year and month
  my $dt = Date.new($y, $m, 1 );

  return $dt;
}

sub GetLastSunday($dt) {
  my $lastdt = $dt.last-date-in-month;        # Get last date and its dow

  my $dow = ($lastdt).day-of-week;

  if $dow == 7 {                               # if not 7, back up until day = 0 (7)

    print("$lastdt\n");

  } else {

    say Date.new($lastdt).earlier(  ( year => 0, month => 0, day => $dow ) );

  }

}

sub MAIN( Int $year = 2022) {              # In no year entered, default to 2022

  for (1..12) -> $m {                      # for each month

    my $dt = CreateDateTime($year, $m);

    GetLastSunday($dt);

  }
}
