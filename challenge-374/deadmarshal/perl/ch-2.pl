#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub largest_same_digit_number{
  my $r = -1;
  while($_[0] =~ /((.)\2*)/g){
    $r = $1 if $r < $1
  }
  0 + $r
}

is largest_same_digit_number('6777133339'),3333,'Example 1';
is largest_same_digit_number('1200034'),4,'Example 2';
is largest_same_digit_number('44221155'),55,'Example 3';
is largest_same_digit_number('88888'),88888,'Example 4';
is largest_same_digit_number('11122233'),222,'Example 5';

done_testing();

