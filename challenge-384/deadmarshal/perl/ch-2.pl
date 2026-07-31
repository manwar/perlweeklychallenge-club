#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub special_binary_substrings {
  my ($b) = @_;
  my @m;
  foreach my $pos(0..length($b)-1){
    foreach my $len(2..length($b) - $pos) {
      my $sub = substr($b,$pos,$len);
      next unless $sub =~ /^(0+1+|1+0+)$/;
      my ($f,$s) = $sub =~ /^(0+)(1+)$/ 
	? ($1,$2) 
	: $sub =~ /^(1+)(0+)$/;
      push @m, $sub if length($f) == length($s);
    }
  }
  \@m;
}

is_deeply special_binary_substrings('0101'),
  ['01','10','01'],'Example 1';
is_deeply special_binary_substrings('000111'),
  ['000111','0011','01'],'Example 2';
is_deeply special_binary_substrings('000011'),
  ['0011','01'],'Example 3';
is_deeply special_binary_substrings('10011100'),
  ['10','0011','01','1100','10'],'Example 4';
is_deeply special_binary_substrings('00000'),[],'Example 5';

done_testing();

