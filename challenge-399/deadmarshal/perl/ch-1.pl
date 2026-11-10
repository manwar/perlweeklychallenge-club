#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub longest_repeating_character{
  my ($s,$k) = @_;
  my ($left,$max_count,%count) = (0,0);
  my $n = length $s;
  foreach my $right(0..$n-1){
    my $c = substr($s,$right,1);
    $count{$c}++;
    $max_count = $count{$c} if $count{$c} > $max_count;
    if(($right - $left + 1) - $max_count > $k){
      $count{substr($s,$left,1)}--;
      $left++
    }
  }
  $n - $left
}

is longest_repeating_character('AAAAA',2),5,'Example 1';
is longest_repeating_character('ABCDE',4),5,'Example 2';
is longest_repeating_character('AAABBBBAA',1),5,'Example 3';
is longest_repeating_character('ABACADA',2),5,'Example 4';
is longest_repeating_character('BAAABAAAA',1),8,'Example 5';

