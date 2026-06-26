#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub digits_sum{
  my ($n) = @_;
  my $sum = 0;
  while($n > 0){
    $sum += $n % 10;
    $n /= 10
  }
  $sum
}

sub alphabet_index_digit_sum{
  my $n = '';
  foreach(split '',$_[0]){
    $n .= int(ord($_) - ord('a') + 1)
  }
  for(my $i = 0; $i < $_[1]; ++$i){
    $n = digits_sum($n)
  }
  $n
}

is alphabet_index_digit_sum('abc',1),6,'Example 1';
is alphabet_index_digit_sum('az',2),9,'Example 2';
is alphabet_index_digit_sum('cat',1),6,'Example 3';
is alphabet_index_digit_sum('dog',2),8,'Example 4';
is alphabet_index_digit_sum('perl',3),6,'Example 5';

