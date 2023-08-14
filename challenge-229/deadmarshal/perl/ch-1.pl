#!/usr/bin/env perl
use strict;
use warnings;

sub lexicographic_order
{
  my $count = 0;
  map{
    my $s = join '',sort split '';
    $count++ if(($s ne $_) && (reverse($s) ne $_))} @{$_[0]};
  $count;
}

printf "%d\n",lexicographic_order(["abc", "bce", "cae"]);
printf "%d\n",lexicographic_order(["yxz", "cba", "mon"]);

