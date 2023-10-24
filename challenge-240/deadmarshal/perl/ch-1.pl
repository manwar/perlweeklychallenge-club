#!/usr/bin/env perl
use strict;
use warnings;

sub acronym{
  CORE::fc (join '',map{substr $_,0,1}@{$_[0]}) eq CORE::fc $_[1];
}

printf "%d\n",acronym(["Perl", "Python", "Pascal"],"ppp");
printf "%d\n",acronym(["Perl", "Raku"],"rp");
printf "%d\n",acronym(["Oracle", "Awk", "C"],"oac");

