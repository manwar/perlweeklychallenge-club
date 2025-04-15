#!/usr/bin/env perl
use strict;
use warnings;

sub acronyms {
  (join '',map{substr $_,0,1} @{$_[0]}) eq $_[1];
}

printf"%d\n",acronyms(['Perl','Weekly','Challenge'],'PWC');
printf"%d\n",acronyms(['Bob','Charlie','Joe'],'BCJ');
printf"%d\n",acronyms(['Morning','Good'],'MM');

