#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub decrypt_string{
  my %h;
  my ($i,$c) = (1,'a');
  $h{$i++} = $c++ foreach 1..9;
  $h{$i++ . '#'} = $c++ foreach 10..26;
  $_[0] =~ s/((?:1\d|2[0-6])#|\d)/$h{$1}/gr
}

is decrypt_string('10#11#12'),'jkab','Example 1';
is decrypt_string('1326#'),'acz','Example 2';
is decrypt_string('25#24#123'),'yxabc','Example 3';
is decrypt_string('20#5'),'te','Example 4';
is decrypt_string('1910#26#'),'aijz','Example 5';

