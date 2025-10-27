#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub last_visitor{
  my ($arr) = @_;
  my (@res,@seen);
  my $k = 0;
  foreach my $i(0..$#$arr) {
    if($arr->[$i] != -1) {
      push @seen,$arr->[$i];
      $k = @seen
    } elsif ($k == 0) {
      push @res,-1
    } else {
      push @res,$seen[--$k]
    }
  }
  @res
}

show last_visitor([5,-1,-1]);
show last_visitor([3,7,-1,-1,-1]);
show last_visitor([2,-1,4,-1,-1]);
show last_visitor([10,20,-1,30,-1,-1]);
show last_visitor([-1,-1,5,-1])
  
