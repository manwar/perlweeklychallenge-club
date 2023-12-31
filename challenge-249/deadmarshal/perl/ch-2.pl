#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub di_string_match{
  my ($i,$j) = (0,length $_[0]);
  (map{$_ eq 'I' ? $i++ : $j--}split '',$_[0]),$i;
}

print show di_string_match('IDID');
print show di_string_match('III');
print show di_string_match('DDI');

