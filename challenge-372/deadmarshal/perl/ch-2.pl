#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub largest_string{
  my $l = 0;
  $l < length $2 and $l = length $2 while $_[0] =~ /(.)(?=(.*)\1)/g;
  $l
}

is largest_string('aaaaa'),3,'Example 1';
is largest_string('abcdeba'),5,'Example 2';
is largest_string('abbc'),0,'Example 3';
is largest_string('abcaacbc'),4,'Example 4';
is largest_string('laptop'),2,'Example 5';

