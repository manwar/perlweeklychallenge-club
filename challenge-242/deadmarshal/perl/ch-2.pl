#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub flip_matrix{
  map{[map {$_^1} reverse @$_]}@{$_[0]};
}

print show flip_matrix([[1,1,0],[1,0,1],[0,0,0]]);
print show flip_matrix([[1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]);

