#!/usr/bin/perl

# Weekly Challenge 187 Task #1
# Two friends, Foo and Bar gone on holidays seperately to the same city. You are given their schedule i.e. start date and end date.
#
# To keep the task simple, the date is in the form DD-MM and all dates belong to the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap year and both dates are inclusive.
#
# Write a script to find out for the given schedule, how many days they spent together in the city, if at all.
###############################
use strict;
use warnings;
use Time::Local qw[timegm];

# Dates of Foo and Bar visits
my @dates_foo=("12-03","20-01","02-03","12-03","02-03","12-03","30-03","05-04"); # Foo's Dates
my @dates_bar=("15-02","18-01","13-03","14-03","11-03","15-03","28-03","02-04"); # Bar's Dates
my $year="2022";

my (@julian_foo, @julian_bar);
my (@overlap, @dates1, @dates2);
my $i;

# Loop by 2s for each date to compare
for ($i=0;$i<$#dates_foo;$i+=2) {
  @dates1=split("-",$dates_foo[$i]);   # Split date for FindJulian function
  @dates2=split("-",$dates_foo[$i+1]); # Split date for FindJulian function
  $julian_foo[0] = FindJulian($year,$dates1[1],$dates1[0]); # Find Julian Day
  $julian_foo[1] = FindJulian($year,$dates2[1],$dates2[0]); # Find Julian Day

  # Repeat for 2nd set of dates;
  @dates1=split("-",$dates_bar[$i]);
  @dates2=split("-",$dates_bar[$i+1]);
  $julian_bar[0] = FindJulian($year,$dates1[1],$dates1[0]);
  $julian_bar[1] = FindJulian($year,$dates2[1],$dates2[0]);

  # Fill arrays with julian days of dates
  @julian_foo = $julian_foo[0] .. $julian_foo[1];
  @julian_bar = $julian_bar[0] .. $julian_bar[1];

  # Find intersection of the two arrays. 
  @overlap = grep { defined } 
    @{ { map { $_ ,=> $_ } @julian_foo } }
       { @julian_bar };

  print "Input: Foo => SD: \'".$dates_foo[$i]."\' ED: \'".$dates_foo[$i+1]."\'\n";
  print "       Bar => SD: \'".$dates_bar[$i]."\' ED: \'".$dates_bar[$i+1]."\'\n";
  print "Output: ".scalar(@overlap)." days\n\n";
}

# Subroutine finds the julian day given a date for the year 2022
sub FindJulian {
  my ($yy, $mm, $dd) = @_;
  my $time1 = timegm(0,0,0, $dd, $mm-1, $yy);
  my $time0 = timegm(0,0,0,1,0,$yy);
  return 1 + int(($time1-$time0)/ 86_400);
}
