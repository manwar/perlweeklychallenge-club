#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;
use Memoize;

memoize qw(derange);
sub derange{
  my ($n) = @_;
  return 1 if $n == 0;
  $n * derange($n-1) + ($n % 2 == 0 ? 1 : -1)
}

is derange(1),0,'Example 1';
is derange(2),1,'Example 2';
is derange(3),2,'Example 3';
is derange(4),9,'Example 4';
is derange(5),44,'Example 5';

done_testing();

