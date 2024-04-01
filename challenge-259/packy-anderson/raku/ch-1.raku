#!/usr/bin/env raku
use v6;

use Date::Names;

sub bankingDayOffset($start, $offset, @holidays) {
  my $date = Date.new($start); # convert string to Date
  my $off  = $offset;
  my $cnt  = 0;

  # convert holidays to Date objects
  @holidays = map { Date.new($_) }, @holidays;

  # instantiate a Date::Names object
  my $dn = Date::Names.new;

  my @explain;
  my $this_day = $dn.dow($date.day-of-week);
  while ($off) {
    $date++;
    my $next_day = $dn.dow($date.day-of-week);
    if (
      $date.day-of-week == 6 || # it's a Saturday
      $date.day-of-week == 7    # it's a Sunday
    ) { 
      @explain.push:
        "$next_day skipped because it's a weekend";
    }
    elsif ($date == @holidays.any) { # it's a Holiday
      @explain.push:
        "$next_day skipped because it's a holiday";
    }
    else {
      $off--; $cnt++;
      @explain.push:
        "$this_day bumped to $next_day (offset $cnt)";
      $this_day = $next_day;
    }
  }
  return $date.gist, @explain.join("\n");
}

sub solution($start, $offset, @holidays) {
  my $holiday_display = '';
  if (@holidays) {
    $holiday_display = qq{,\n       \$bank_holidays = ['}
                     ~ @holidays.join(q{', '}) ~ q{']};
  }
  say qq{Input: \$start_date = '$start', \$offset = $offset$holiday_display};
  my ($output, $explain) = bankingDayOffset($start, $offset, @holidays);
  say qq{Output: '$output'};
  say qq{\n$explain};
}

say "Example 1:";
solution('2018-06-28', 3, ['2018-07-03']);

say "\nExample 2:";
solution('2018-06-28', 3, []);

say "\nExample 3:";
solution('2023-12-29', 5, ['2024-01-01']);