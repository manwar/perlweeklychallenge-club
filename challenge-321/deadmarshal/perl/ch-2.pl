#!/usr/bin/env perl
use strict;
use warnings;

sub backspace_compare{
  my ($s1,$s2) = @_;
  for($s1,$s2){
    1 while s/[^#]#//
  }
  $s1 eq $s2
}

printf "%d\n",backspace_compare('ab#c','ad#c');
printf "%d\n",backspace_compare('ab##','a#b#');
printf "%d\n",backspace_compare('a#b','c');

