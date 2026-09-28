#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);
use ntheory qw(is_prime);
use Test::More tests => 5;

sub prime_step{
  my $sum = sum0 map{ord} split '',$_[0];
  my $d = 0;
  while(1){
    return $d if is_prime($sum - $d) || is_prime($sum + $d);
    $d++
  }
}

is prime_step('hello'),9,'Example 1';
is prime_step('football'),2,'Example 2';
is prime_step('a'),0,'Example 3';
is prime_step('challenge'),2,'Example 4';
is prime_step('perl'),2,'Example 5';

done_testing();

