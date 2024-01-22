#!usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub unique_sum_zero{
  my ($n,@ret) = @_;
  foreach(1..$n/2){
    push(@ret,$_,-$_);
  }
  $n % 2 ? (@ret,0) : @ret;
}

print show unique_sum_zero(5);
print show unique_sum_zero(3);
print show unique_sum_zero(1);
