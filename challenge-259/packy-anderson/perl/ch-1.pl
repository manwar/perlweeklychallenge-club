#!/usr/bin/env perl
use v5.38;

use List::Util qw( any );
use Time::Piece;
use Time::Seconds qw( ONE_DAY );

sub bankingDayOffset($start, $offset, @holidays) {
  # convert string to Date
  my $date = Time::Piece->strptime($start, "%Y-%m-%d")
                        ->truncate(to => 'day');
  my $cnt  = 0;

  # convert holidays to Date objects
  @holidays = map {
    Time::Piece->strptime($_, "%Y-%m-%d")
               ->truncate(to => 'day')
  } @holidays;

  my @explain;
  my $this_day = $date->fullday;
  while ($offset) {
    $date += ONE_DAY; # add 1 day
    my $next_day = $date->fullday;
    if (
      $date->wday == 7 || # it's a Saturday
      $date->wday == 1    # it's a Sunday
    ) { 
      push @explain,
        "$next_day skipped because it's a weekend";
    }
    elsif (any { $date == $_ } @holidays) { # it's a Holiday
      push @explain,
        "$next_day skipped because it's a holiday";
    }
    else {
      $offset--; $cnt++;
      push @explain,
        "$this_day bumped to $next_day (offset $cnt)";
      $this_day = $next_day;
    }
  }
  return $date->strftime('%F'), join("\n", @explain);
}

sub solution($start, $offset, @holidays) {
  my $holiday_display = '';
  if (@holidays) {
    $holiday_display = qq{,\n       \$bank_holidays = ['}
                     . join(q{', '}, @holidays) . q{']};
  }
  say qq{Input: \$start_date = '$start', \$offset = $offset$holiday_display};
  my ($output, $explain) = bankingDayOffset($start, $offset, @holidays);
  say qq{Output: '$output'};
  say qq{\n$explain};
}

say "Example 1:";
solution('2018-06-28', 3, '2018-07-03');

say "\nExample 2:";
solution('2018-06-28', 3);

say "\nExample 3:";
solution('2023-12-29', 5, '2024-01-01');