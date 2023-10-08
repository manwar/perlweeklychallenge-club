#!/usr/bin/env perl
use strict;
use warnings;
use Date::Calc qw(Nth_Weekday_of_Month_Year);

sub seize_the_day{
  (Nth_Weekday_of_Month_Year($_[0],$_[1],$_[3],$_[2]))[2] // 0;
}

printf "%d\n",seize_the_day(2024,4,3,2);
printf "%d\n",seize_the_day(2025,10,2,4);
printf "%d\n",seize_the_day(2026,8,5,3);

