#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq sum0);

sub similar_words{
  my ($count,%h) = (0);
  map{$h{join '',uniq sort split ''}++} @{$_[0]};
  $count += ($_ * ($_-1)) / 2 foreach values %h;
  $count
}

printf "%d\n", similar_words(["aba","aabb","abcd","bac","aabc"]);
printf "%d\n", similar_words(["aabb","ab","ba"]);
printf "%d\n", similar_words(["nba","cba","dba"]);

