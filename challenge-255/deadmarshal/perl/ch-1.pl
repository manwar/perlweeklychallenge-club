#!/usr/bin/env perl
use strict;
use warnings;

sub odd_character{
  my %h;
  map{++$h{$_}}split '',$_[0];
  map{--$h{$_}||delete $h{$_}}split '',$_[1];
  keys %h
}

printf "%s\n",odd_character("Perl","Preel");
printf "%s\n",odd_character("Weekly","Weeakly");
printf "%s\n",odd_character("Box","Boxy");

