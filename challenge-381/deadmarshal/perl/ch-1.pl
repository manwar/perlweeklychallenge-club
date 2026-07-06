#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub same_row_column{
  my ($m) = @_;
  my $n = @$m;

  foreach my $row (@$m){
    my %h;
    foreach my $num(@$row){
      return 0 if ($num < 1 || $num > $n || $h{$num}++);
    }
  }
  
  foreach my $col(0..$n-1){
    my %h;
    foreach my $row(@$m){
      my $num = $row->[$col];
      return 0 if ($num < 1 || $num > $n || $h{$num}++);
    }
  }
  1
}

is same_row_column([[1,2,3,4],[2,3,4,1],
		    [3,4,1,2],[4,1,2,3]]),1,'Example 1';
is same_row_column([[1]]),1,'Example 2';
is same_row_column([[1,2,5],[5,1,2],[2,5,1]]),0,'Example 3';
is same_row_column([[1,2,3],[1,2,3],[1,2,3]]),0,'Example 4';
is same_row_column([[1,2,3],[3,2,1],[3,2,1]]),0,'Example 5';

done_testing();

