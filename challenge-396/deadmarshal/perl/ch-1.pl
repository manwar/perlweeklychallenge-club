#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub finishing_order{
  my %h;
  $h{$_} = 1 foreach @{$_[1]};
  [grep {$h{$_}} @{$_[0]}];
}

is_deeply finishing_order([3,1,4,2,5],[1,2,4]),[1,4,2],'Example 1';
is_deeply finishing_order([5,4,3,2,1],[1,3,5]),[5,3,1],'Example 2';
is_deeply finishing_order([2,4,1,3],[1,2,3,4]),[2,4,1,3],'Example 3';
is_deeply finishing_order([4,1,3,2],[3]),[3],'Example 4';
is_deeply finishing_order([1,3,2,6,5,4],[1,2,3]),[1,3,2],'Example 5';

