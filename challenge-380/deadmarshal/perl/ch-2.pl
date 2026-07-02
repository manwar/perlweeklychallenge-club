#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);
use Test::More tests => 5;

sub reverse_degree{
  my ($i,%h) = (1);
  @h{'a'..'z'} = reverse 1..26;
  sum0 map {$h{$_} * $i++} split '',lc $_[0]
}

is reverse_degree('z'),1,'Example 1';
is reverse_degree('a'),26,'Example 2';
is reverse_degree('bbc'),147,'Example 3';
is reverse_degree('racecar'),560,'Example 4';
is reverse_degree('zyx'),14,'Example 5';

done_testing();

