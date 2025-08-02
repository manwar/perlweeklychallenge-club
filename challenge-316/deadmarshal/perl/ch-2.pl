#!/usr/bin/env perl
use strict;
use warnings;

sub subsequence{
  my @idx = map{index $_[1],$_} split '',$_[0];
  join('',@idx) eq join '',sort{$a <=> $b} @idx
}

printf "%d\n",subsequence('uvw','bcudvew');
printf "%d\n",subsequence('aec','abcde');
printf "%d\n",subsequence('sip','javascript');

