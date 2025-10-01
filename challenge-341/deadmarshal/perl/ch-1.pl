#!/usr/bin/env perl
use strict;
use warnings;

sub broken_keyboard{
  my $chars = join '',@{$_[1]};
  scalar grep {$chars eq '' || !/[$chars]/i} split /\W+/,$_[0];
}

printf "%d\n",broken_keyboard('Hello World',['d']);
printf "%d\n",broken_keyboard('apple banana cherry',['a','e']);
printf "%d\n",broken_keyboard('Coding is fun',['']);
printf "%d\n",broken_keyboard('The Weekly Challenge',['a','b']);
printf "%d\n",broken_keyboard('Perl and Python',['p'])

