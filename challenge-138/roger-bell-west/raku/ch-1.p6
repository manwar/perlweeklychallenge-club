#! /usr/bin/perl6

use Test;

plan 2;

is(workdays(2021),260,'example 1');
is(workdays(2020),262,'example 2');

sub p($y) {
  return ($y+floor($y/4)-floor($y/100)+floor($y/400))%7;
}

sub leapyear($y) {
  return ($y%4==0 && ($y%100 != 0 || $y%400 == 0));
}

sub workdays($y) {
  my $i=p($y);
  if (leapyear($y)) {
    $i+=7;
  }
  return 260+[0,1,1,1,1,0,0,1,2,2,2,2,1].[$i];
}
