#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub similar_dominos{
  my %h;
  $h{join '',sort{$a <=> $b} @$_}++ foreach @{$_[0]};
  sum0 grep{$_>1} values %h
}

printf "%d\n",similar_dominos([[1,3],[3,1],[2,4],[6,8]]);
printf "%d\n",similar_dominos([[1,2],[2,1],[1,1],[1,2],[2,2]]);

