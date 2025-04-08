#!/usr/bin/env perl
use strict;
use warnings;

sub circular{
  for(my $i = 0; $i < $#{$_[0]}; $i++) {
    my $l = substr($_[0]->[$i],-1);
    my $f = substr($_[0]->[$i+1],0,1);
    return 0 unless $l eq $f
  }
  1
}

printf "%d\n",circular(['perl','loves','scala']);
printf "%d\n",circular(['love','the','programming']);
printf "%d\n",circular(['java','awk','kotlin','node.js']);

