#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub sort_language{
  @{$_[0]}[map{$_-1}@{$_[1]}];
}

print show sort_language(['perl','c','python'],[2,1,3]);
print show sort_language(['c++','haskell','java'],[1,3,2]);

