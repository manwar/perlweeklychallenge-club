#!perl.exe

use strict;
use warnings;
use DateTime;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-25
# Challenge 175 Last Sunday ( Perl )

my @molen = qw( 31 28 31 30  31 30 31 31 30 31 30 31);

sub CreateDateTime {                # create a Date object for year and month
  my $y = shift;
  my $m = shift;

  my $dt = DateTime->last_day_of_month(year => $y, month => $m);

  return $dt;
}

sub CheckLeapYear {                 # Adjust February if leap year
  my $dt = shift;

  if($dt->is_leap_year){

      $molen[1] = 29;

  }
}

sub GetLastSunday {                 # back up until we land on Sunday
    my $dt = shift;

    my $dow = $dt->day_of_week;

    if($dow != 7 ){

      $dt->subtract(days=>$dow);

    }

    return $dt;

}

my $count = 1;

my $year = $ARGV[0];

while( $count <= 12){

  my $dt = CreateDateTime($year, $count);

  CheckLeapYear($dt);

  $dt = GetLastSunday($dt);

  print($dt->ymd . "\n");

  $count++;

}
