use strict;
use warnings;
use DateTime;
use List::Util qw/min max/;

sub get_work_days {
  my $what = shift;

    my $dt_1_1 = DateTime->new(
      year => $what,
      month => 1,
      day => 1);


    my $dt_31_12 = DateTime->new(
      year => $what,
      month => 12,
      day => 31);

  
  my $weeks_in_year = $dt_31_12->week_number;
  $weeks_in_year += 1 if $dt_1_1->week_number != 1;

  my $result = $weeks_in_year * 5;

  # deduct left over days at the end of the year
  $result -= max(5-$dt_31_12->day_of_week, 0);

  # deduct days at the beginning of the year
  $result -= min($dt_1_1->day_of_week-1, 5);

  return $result;
}

use Test::More;

is(get_work_days(2021), 261);
is(get_work_days(2020), 262);


done_testing;
