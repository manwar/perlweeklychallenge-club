#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(cz(2017),'Fire Rooster','example 1');
is(cz(1938),'Earth Tiger','example 2');

sub cz {
  my $yy=shift;
  my $y=$yy;
  if ($y<0) {
    $y++;
  }
  $y%=60;
  while ($y<0) {
    $y+=60;
  }
  return join(' ',
              [qw(Metal Water Wood Fire Earth)]->[int($y/2)%5],
              [qw(Monkey Rooster Dog Pig Rat),'Water Buffalo',qw(Tiger Cat Dragon Snake Horse Goat)]->[$y%12]);
}
