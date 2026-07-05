#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub reverse_existence{
  0 + $_[0] =~ /(?=(.)(.))(?=.*\2\1)/
}

is reverse_existence('abcba'),1,'Example 1';
is reverse_existence('racecar'),1,'Example 2';
is reverse_existence('abcd'),0,'Example 3';
is reverse_existence('banana'),1,'Example 4';
is reverse_existence('hello'),1,'Example 5';

done_testing();

