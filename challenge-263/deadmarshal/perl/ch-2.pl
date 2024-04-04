#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub merge_items{
  my %h;
  $h{$_->[0]} += $_->[1] foreach(@{$_[0]},@{$_[1]});
  map{[$_,$h{$_}]} sort{$a <=> $b} keys %h;
}

print show merge_items([[1,1],[2,1],[3,2]],[[2,2],[1,3]]);
print show merge_items([[1,2],[2,3],[1,3],[3,2]],[[3,1],[1,3]]);
print show merge_items([[1,1],[2,2],[3,3]],[[2,3],[2,4]]);

