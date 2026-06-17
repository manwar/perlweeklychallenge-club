#!/usr/bin/env perl
use strict;
use warnings;

sub equal_list{
  (join '',@{$_[0]}) eq (join '',@{$_[1]})
}

printf "%d\n",equal_list(['a','bc'],['ab','c']);
printf "%d\n",equal_list(['a','b','c'],['a','bc']);
printf "%d\n",equal_list(['a','bc'],['a','c','b']);
printf "%d\n",equal_list(['ab','c',''],['','a','bc']);
printf "%d\n",equal_list(['p','e','r','l'],['perl']);
  
