#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub zig_zag_subarray{
  my ($arr) = @_;
  return 1 if @{$arr} == 1;
  return 2 if @{$arr} == 2 && $arr->[0] != $arr->[1];
  my ($max,$from,$to) = (1,0,0);
  while($to++ < $#$arr){
    $from = $to, next if $arr->[$to-1] == $arr->[$to];
    $from = $to-1, next if $to - $from > 1
      && ($arr->[$to] <=> $arr->[$to-1]) 
      == ($arr->[$to-1] <=> $arr->[$to-2]);
    my $curr = 1 + $to - $from;
    $max = $curr if $curr > $max
  }
  $max
}

is zig_zag_subarray([9,4,2,10,7,8,8,1,9]),5,'Example 1';
is zig_zag_subarray([1,7,4,9,2,5]),6,'Example 2';
is zig_zag_subarray([1..5]),2,'Example 3';
is zig_zag_subarray([4,4,4]),1,'Example 4';
is zig_zag_subarray([10,20,15,12,18]),3,'Example 5';

done_testing();

