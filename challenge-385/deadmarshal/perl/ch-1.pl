#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub uncommon_words{
  my %h;
  $h{$_}++ foreach split /\s+/,"$_[0] $_[1]";
  grep {$h{$_} == 1} keys %h
}

show uncommon_words('apple banana apple','banana orange');
show uncommon_words('cat dog','bird fish');
show uncommon_words('the quick brown fox','the quick');
show uncommon_words('hello','hello');
show uncommon_words('blue blue red','red green green yellow');

