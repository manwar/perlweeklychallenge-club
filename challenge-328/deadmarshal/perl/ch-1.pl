#!/usr/bin/env perl
use strict;
use warnings;

sub replace_all{
  my %h = map{$_ => 1} split '',$_[0];
  my @chars = grep{!exists $h{$_}} 'a'..'z';
  $_[0] =~ s/\?/$chars[0]/r
}

printf "%s\n",replace_all('a?z');
printf "%s\n",replace_all('pe?k');
printf "%s\n",replace_all('gra?te');

