#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(workdays(2021),260,'example 1');
is(workdays(2020),262,'example 2');

sub p {
  my $y=shift;
  return ($y+int($y/4)-int($y/100)+int($y/400))%7;
}

sub leapyear {
  my $y=shift;
  return ($y%4==0 && ($y%100 !=0 || $y%400==0));
}

sub workdays {
  my $y=shift;
  my $i=p($y);
  if (leapyear($y)) {
    $i+=7;
  }
  return 260+[0,1,1,1,1,0,0,1,2,2,2,2,1]->[$i];
}
