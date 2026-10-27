#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;
use List::Util qw(max sum0);

sub absent_smallest_positive{
  my ($arr) = @_;
  my ($sum,%h);
  foreach(@$arr){
    $h{$_} = 1;
    $sum += $_;
  }
  my $ret = max(1,int($sum / @$arr) + 1);
  $ret++ while(exists $h{$ret});
  $ret
}

is absent_smallest_positive([1,2,4,5,6]),7,'Example 1';
is absent_smallest_positive([-5,-2,-1,3]),1,'Example 2';
is absent_smallest_positive([1..3]),4,'Example 3';
is absent_smallest_positive([2,3,7,8]),6,'Example 4';
is absent_smallest_positive([1,1,1,10]),4,'Example 5';

