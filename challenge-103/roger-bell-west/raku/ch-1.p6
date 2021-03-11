#! /usr/bin/perl6

use Test;

plan 2;

is(cz(2017),'Fire Rooster','example 1');
is(cz(1938),'Earth Tiger','example 2');

sub cz($yy) {
  my $y=$yy;
  if ($y < 0) {
    $y++;
  }
  $y%=60;
  while ($y < 0) {
    $y+=60;
  }
  return join(' ',
    [qw|Metal Water Wood Fire Earth|].[floor($y/2)%5],
    ['Monkey','Rooster','Dog','Pig','Rat','Water Buffalo','Tiger','Cat','Dragon','Snake','Horse','Goat'].[$y%12]);
}
