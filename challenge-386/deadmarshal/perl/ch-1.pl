#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

my $i = 0;
my %val = map {$_ => $i++} 0..9,'A'..'Z','a'..'z','+','/';

sub reverse_base{
  my ($num,$base) = @_;
  my $res = 0;
  for(my $n = 1; length $num; $n *= $base) {
    $res += $n * $val{substr $num,-1,1,''}
  }
  $res
}

is reverse_base('101010',2),42,'Example 1';
is reverse_base('EEADEE',16),15642094,'Example 2';
is reverse_base('755',8),493,'Example 3';
is reverse_base('1BRJB',36),2228519,'Example 4';
is reverse_base('7MyqL',64),123456789,'Example 5';

done_testing();

