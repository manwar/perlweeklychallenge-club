#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub uncommon_words{
  my %h;
  $h{lc $_}++ foreach split /\W+/, $_[0] . ' ' . $_[1];
  sort grep{$h{$_} == 1} keys %h;
}

print show uncommon_words('Mango is sweet','Mango is sour');
print show uncommon_words('Mango Mango','Orange');
print show uncommon_words('Mango is Mango','Orange is Orange');

