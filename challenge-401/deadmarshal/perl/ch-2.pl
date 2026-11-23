#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

my @STEPS = (
  [0,'z','zero'],
  [2,'w','two'],
  [4,'u','four'],
  [6,'x','six'],
  [8,'g','eight'],
  [3,'h','three'],
  [5,'f','five'],
  [7,'s','seven'],
  [1,'o','one'],
  [9,'i','nine'],
);

sub reconstruct_digits{
  my ($str) = @_;
  my %count;
  $count{$_}++ for split '',$str;

  my @times = (0) x 10;
  foreach my $step(@STEPS){
    my ($digit,$key,$word) = @$step;
    my $n = $count{$key} or next;
    $times[$digit] = $n;
    $count{$_} -= $n for split '',$word;
  }
  join '',map{$_ x $times[$_]} 0..9
}

is reconstruct_digits('zroezerotwotwotwo'),'00222','Example 1';
is reconstruct_digits('sveeneinght'),'78','Example 2';
is reconstruct_digits('onenineninefive'),'1599','Example 3';
is reconstruct_digits('zeroonetwothreeeightfivesixsevenninefour'),
  '0123456789','Example 4';
is reconstruct_digits('ninenineninenine'),'9999','Example 5';

