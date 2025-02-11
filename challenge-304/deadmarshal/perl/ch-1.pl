#!/usr/bin/env perl
use strict;
use warnings;

sub arrange_binary{
  my $c = 0;
  map{$c++ if $_[0]->[$_] == 0 && $_[0]->[$_+1] == 0} 0..$#{$_[0]}-1;
  $c > $_[1]
}

printf "%d\n",arrange_binary([1,0,0,0,1],1);
printf "%d\n",arrange_binary([1,0,0,0,1],2);

