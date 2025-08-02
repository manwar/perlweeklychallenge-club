#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub number_game{
  my @arr = sort{$a <=> $b} @{$_[0]};
  my @ret;
  push @ret,reverse splice @arr,0,2 while(@arr);
  @ret
}

print show number_game([2,5,3,4]);
print show number_game([9,4,1,3,6,4,6,1]);
print show number_game([1,2,2,3]);

