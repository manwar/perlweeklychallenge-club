#!/usr/bin/env perl
use strict;
use warnings;

sub sort_string{
  my %h = map{/(\w+)(\d+)/} split ' ',$_[0];
  join ' ',sort{$h{$a} <=> $h{$b}} keys %h
}

printf "%s\n",sort_string('and2 Raku3 cousins5 Perl1 are4');
printf "%s\n",
  sort_string('guest6 Python1 most4 the3 popular5 is2 language7');
printf "%s\n",sort_string('Challenge3 The1 Weekly2');

