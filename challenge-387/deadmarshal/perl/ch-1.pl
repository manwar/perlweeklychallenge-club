#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub rearrange_binary_string{
  my ($s) = @_;
  my $c = 0;
  $c++ while $s =~ s/01/10/g;
  $c
}

is rearrange_binary_string('111000'),0,'Example 1';
is rearrange_binary_string('00011'),4,'Example 2';
is rearrange_binary_string('01011'),3,'Example 3';
is rearrange_binary_string('010101'),3,'Example 4';
is rearrange_binary_string('00001'),4,'Example 5';

done_testing();

